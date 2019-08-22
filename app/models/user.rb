class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def token
    ENV['GITHUB_TOKEN']
  end

  def friendship_uids
    joins(:friendships).select('users.uid').where(friendships: {user_id: id})
  end
end
