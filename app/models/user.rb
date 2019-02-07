class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, if: :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def bookmark_videos
    # binding.pry
    Video.joins(:user_videos)
    .where("videos.id = user_videos.video_id")
    .where("user_videos.user_id = ?", id)
    .order(:position)
    .order(:tutorial_id)
  end
end
