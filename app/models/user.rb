class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :password, on: :create, presence: true
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  has_many :friendships
  has_many :friends, through: :friendships

  def self.check_for_username?(username)
    users = User.where(username: username)
    return false if users.empty?

    true
  end

  def bookmarked_videos
    videos.order('position').group_by(&:tutorial)
  end
end
