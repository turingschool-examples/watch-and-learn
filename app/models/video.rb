class Video < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.bookmarked_videos
    order('position').group_by { |video| video.tutorial}
  end
end
