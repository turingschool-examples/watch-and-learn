class Tutorial < ApplicationRecord
  has_many :videos, ->  { order(position: :ASC) }
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
  
  def self.bookmarked(user)
    Tutorial.joins(videos: :user_videos)
            .where(user_videos: {user_id: user})
            .distinct
  end
  
  def bookmarked_videos(user)
    videos.joins(:user_videos)
          .where(user_videos: {user_id: user})
          .order(:position)
  end
end
