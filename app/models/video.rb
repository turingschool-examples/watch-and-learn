class Video < ApplicationRecord
  scope :position, -> { where(position: :ASC) }
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
  validates_presence_of :position
end
