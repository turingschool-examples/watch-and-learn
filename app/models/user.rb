# frozen_string_literal: true

# model for users
class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :user_friendships, class_name: 'Friendship'
  has_many :friendships, through: :user_friendships,
                         source: :friendship

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def active?
    status == 'active'
  end

  def activation_email
    ActivationMailer.inform(self).deliver_now
  end

  def self.from_omniauth(user_id, auth)
    user = User.find(user_id)
    if user.username.nil?
      user.create_from_omniauth(auth)
    else
      user.update(github_token: auth['credentials']['token'])
    end
    user
  end

  def create_from_omniauth(auth)
    update(github_token: auth['credentials']['token'])
    update(username: auth['info']['nickname'])
  end

  def bookmarked_vids
    @vids = videos.includes(:tutorial)
  end

  def tut_titles
    bookmarked_vids
    titles = []
    @vids.each do |vid|
      titles << vid.tutorial.title
    end
    titles.uniq
  end

  def github_user(username)
    User.find_by(username: username)
  end

  def friendship?(username)
    user = github_user(username)
    unless user.nil?
      friends = Friendship.where(user_id: id, friendship_id: user.id)[0]
      true unless friends.nil?
    end
  end
end
