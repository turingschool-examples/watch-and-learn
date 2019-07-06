# frozen_string_literal: true

class Video < ApplicationRecord
  validates_presence_of :position

  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
  after_create :update_position

  def update_position
    binding.pry
  end

end
