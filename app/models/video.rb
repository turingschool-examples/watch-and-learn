class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates_presence_of :position
  validates_numericality_of :position, greater_than_or_equal_to: 0
end
