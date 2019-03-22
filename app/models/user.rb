class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email,
    uniqueness: true,
    presence: true,
    length: {
      minimum: 1
    }
  validates :first_name,
    presence: true,
    length: {
      minimum: 1
    }
  validates :last_name,
    presence: true,
    length: {
      minimum: 1
    }
  validates :password,
    confirmation: true
  has_secure_password

  enum role: [:default, :admin]

  def self.bookmarked_videos(user)
    Video.joins(:user_videos, :tutorial)
         .where(user_videos: {user_id: user})
         .order('tutorials.id ASC, videos.position ASC')
  end
end
