class Tutorial < ApplicationRecord
  has_many :videos, ->  { order(position: :ASC) }
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.class_content
    where(classroom: true)
  end

  def self.non_class_content
    where(classroom: false)
  end

  def self.bookmarked_by(user)
    joins(videos: :user_videos)
    .where("user_videos.user_id = ?", user.id)
  end

  def bookmarked_tutorial_videos(user)
    videos.joins(:user_videos)
          .order(position: :asc) 
  end
end
