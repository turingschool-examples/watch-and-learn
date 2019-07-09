# frozen_string_literal: true

class Video < ApplicationRecord
  validates_presence_of :position

  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
  after_create :update_position

  def update_position
    position = 1 if position.nil?
  end

  def self.order_by_tutorial_id
    order(:tutorial_id, :position)
  end

end
