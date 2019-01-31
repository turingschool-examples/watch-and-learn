class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships, class_name: 'User'

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def self.user_in_database(github_username)
    User.find_by(github_username: github_username)
  end

  def user_not_friend(github_username)
    user = User.user_in_database(github_username)
  end
end
