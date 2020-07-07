class User < ApplicationRecord
  has_many :friends,  foreign_key: 'friend_id',
                      class_name: 'Friendship',
                      inverse_of: :user,
                      dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, on: create
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def self.github_usernames
    User.pluck(:github_username).compact
  end
end
