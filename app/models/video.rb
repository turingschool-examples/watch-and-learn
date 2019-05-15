class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates_numericality_of :position

  def self.bookmarked_videos(user)
    joins(:user_videos)
    .where("user_videos.user_id = ?", user.id)
  end
end
