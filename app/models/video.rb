# frozen_string_literal: true

# model for videos
class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  # default_scope { order(:position) }
end
