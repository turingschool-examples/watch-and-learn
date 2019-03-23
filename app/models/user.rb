class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, if: :password
  validates_presence_of :first_name
  validates_uniqueness_of :uid, :allow_nil => true
  enum role: [:default, :admin]
  has_many :friendships
  has_many :friends, through: :friendships
  has_secure_password
end
