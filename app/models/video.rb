# frozen_string_literal: true

class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
  validates_presence_of :position

  def self.ordered_grouped_videos
    self.select("videos.tutorial_id, videos.title, videos.position")
    .order(:position)
    .group_by(&:tutorial_id)
  end
end
