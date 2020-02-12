class Video < ApplicationRecord
  validates_presence_of :position, :description, :title, :video_id

  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
end
