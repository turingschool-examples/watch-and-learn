# frozen_string_literal: true

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
    self.update!(github_token: auth['credentials']['token'])
    self.update!(username: auth['info']['nickname'])
  end

  def bookmarked_vids
  #   vids = Video.joins(:users).includes(:tutorial)
  #        .select('tutorials.title as tutorial_title')
  #        .group(:id, 'tutorial.id')
  #        .order(:tutorial_id)
  #        .order(:position)
         # Tutorial.joins(videos: :user_videos).includes(:videos).where(user_videos: {user_id: self.id}).group(:id)
         # binding.pry
  end

  def github_user(username)
    User.find_by(username: username)
  end

  def friendship?(username)
    user = self.github_user(username)
    if user != nil
      friends = Friendship.where(user_id: self.id, friendship_id: user.id)[0]
      if friends != nil
        true
      end
    else
      nil
    end
  end
end
