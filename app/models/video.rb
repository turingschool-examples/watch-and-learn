# frozen_string_literal: true

# == Schema Information
#
# Table name: videos
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  video_id    :string
#  thumbnail   :string
#  tutorial_id :bigint
#  position    :integer          default(0)
#


class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial
end
