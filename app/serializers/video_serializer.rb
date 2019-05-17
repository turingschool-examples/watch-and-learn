# frozen_string_literal: true

# serializer for videos
class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :position
end
