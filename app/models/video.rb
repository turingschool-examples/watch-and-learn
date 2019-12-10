class Video < ApplicationRecord
  validates_presence_of :position
  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos
  belongs_to :tutorial
end
