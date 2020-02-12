class Video < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos
  belongs_to :tutorial
end
