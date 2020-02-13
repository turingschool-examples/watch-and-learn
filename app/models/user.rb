# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Friendship'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Friendship'
  has_many :followers, through: :following_users

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
  validates_presence_of :first_name
  enum role: %i[default admin]
  enum status: { inactive: 0, active: 1 }
  has_secure_password

  def repositories
    github = Github.new(token)
    json = github.repos
    repositories = json.each_with_object([]) do |repo, acc|
      acc << { name: repo['name'], link: repo['html_url'] }
    end
    repositories[0..4]
  end

  def git_followers
    github = Github.new(token)
    json = github.followers
    json.each_with_object([]) do |user, acc|
      acc << if User.find_by(github_id: user['id'])
               { name: user['login'], link: user['html_url'], github_id: user['id'] }
             else
               { name: user['login'], link: user['html_url'] }
             end
    end
  end

  def git_following
    github = Github.new(token)
    json = github.following
    json.each_with_object([]) do |user, acc|
      acc << if User.find_by(github_id: user['id'])
               { name: user['login'], link: user['html_url'], github_id: user['id'] }
             else
               { name: user['login'], link: user['html_url'] }
             end
    end
  end

  def update_token(auth_hash)
    update!(token: auth_hash[:credentials][:token], github_id: auth_hash[:uid])
    save
  end

  def already_friends(github_id)
    user = User.find_by(github_id: github_id)
    !followees.include?(user)
  end

  def validate_email
    self.email_confirmed = true
    self.confirm_token = nil
  end

  def set_confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s
  end

  def bookmarks
    videos.order('videos.tutorial_id, videos.position').includes(:tutorial)
  end

  def confirmation_procedure
    set_confirmation_token
    VerificationEmailNotifierMailer.inform(self, email).deliver_now
  end
end
