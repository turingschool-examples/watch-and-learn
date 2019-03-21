class UserVideo < ApplicationRecord
  belongs_to :video, foreign_key: "video_id"
  belongs_to :user, foreign_key: "user_id"

  def self.bookmarked_videos(user)
    select("user_videos.*")
    .joins(video: [:tutorial])
    .where(user: user)
  end
end
