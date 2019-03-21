class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def self.bookmarked_videos(user)
    Video.joins(:user_videos, :tutorial)
              .where(user_videos: {user_id: user})
              .order('tutorials.id ASC, videos.position ASC')
  end
end
