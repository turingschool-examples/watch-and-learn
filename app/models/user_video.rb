class UserVideo < ApplicationRecord
  belongs_to :video, foreign_key: 'video_id'
  belongs_to :user, foreign_key: 'user_id'

  def self.bookmarks(user_id)
    joins(video: :tutorial)
      .select('tutorials.title as tutorial_title,
                videos.id as video_id,
                videos.title as video_title')
      .where(user_id: user_id)
  end
end
