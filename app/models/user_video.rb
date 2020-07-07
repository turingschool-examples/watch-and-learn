class UserVideo < ApplicationRecord
  belongs_to :video
  belongs_to :user

  def self.sort_by_tutorial

    videos = all.map { |user_video| user_video.video }
    grouped_videos = videos.group_by { |video| video.tutorial }
    grouped_videos.map do |tutorial, videos|
      [tutorial, videos.sort_by { |video| video.position }]
    end.to_h
  end
end
