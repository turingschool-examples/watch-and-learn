class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def friendships?
    friendships.count > 0
  end

  def friend?(user_login)
    friendships.any? do |friend|
      friend.login == user_login
    end
  end

end
