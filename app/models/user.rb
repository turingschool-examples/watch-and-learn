# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
  validates_presence_of :first_name

  has_many :friendships
  has_many :friends, through: :friendships

  #has_many :followers, foreign_key: :followed_user_id, class_name: 'Following'
  #has_many :follower_users, through: :followers, source: :user

  enum role: %i[default admin]
  has_secure_password
end
