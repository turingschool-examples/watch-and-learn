class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def self.user_in_database(username)
    User.find_by(username: username)
  end

  def user_not_friend(username)
    user = User.user_in_database(username)
    !friends.include?(user)
  end
end
