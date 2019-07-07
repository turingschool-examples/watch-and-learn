# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friended_users, foreign_key: :friend_id, class_name: 'Friend'

  has_many :friends, through: :friended_users

  # has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  #
  # has_many :followees, through: :followed_users
  #
  # has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  # has_many :followers, through: :following_users

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def self.all_github_usernames
    User.all.pluck(:github_username)
  end
end
