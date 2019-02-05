class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
  def self.update_each_position
    update_count = Video.all.reduce(0) do |count, video|
      next(count) unless [0,nil].include?(video.position)
      video.update(position: video.tutorial.videos.maximum(:position) + 1 )
      count += 1
    end
  end
end
