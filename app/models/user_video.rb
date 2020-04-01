class UserVideo < ApplicationRecord
  belongs_to :video, foreign_key: "video_id"
  belongs_to :user, foreign_key: "user_id"

  def self.get_bookmarked_video_info(id)
    joins(video: :tutorial)
    .select('videos.title, videos.id AS video_id, tutorials.id AS tutorial_id')
    .select('tutorials.title AS tutorial_title, videos.position AS video_position')
    .where(user_id: id)
    .order(:tutorial_title)
    .order(:video_position)
  end
end
