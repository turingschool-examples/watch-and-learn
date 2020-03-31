class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  validates_presence_of :username, allow_blank: true
  validates_presence_of :uid, allow_blank: true
  validates_presence_of :github_token, allow_blank: true
  enum role: [:default, :admin]
  has_secure_password
end
