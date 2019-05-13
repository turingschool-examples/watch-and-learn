class User < ApplicationRecord
  has_many :friends
  has_many :followed_users, through: :friends

  has_many :followed_users, foreign_key: :followed_user_id, class_name: 'Friend'
  # has_many :followed_users, through: :friends, source: :user

  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  # validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password
end
