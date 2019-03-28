class Video < ApplicationRecord
  validates :position, presence: true
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
end
