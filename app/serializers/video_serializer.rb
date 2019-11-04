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
#  position    :integer          default(0), not null
#

class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :position
end
