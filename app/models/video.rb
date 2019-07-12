# frozen_string_literal: true

class Video < ApplicationRecord
  validates_presence_of :position, :title, :description, :video_id

  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.order_by_tutorial_id
    order(:tutorial_id, :position)
  end

  def get_thumbnail
    self.thumbnail = YouTube::Video.by_id(self.video_id).thumbnail
    self.save
  end

end
