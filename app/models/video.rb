# frozen_string_literal: true

class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.vidoes_by_tutorial
    order('position ASC').group_by(&:tutorial_id)
  end
end
