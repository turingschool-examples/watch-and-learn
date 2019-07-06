# frozen_string_literal: true

class TutorialSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :thumbnail, :videos

  has_many :videos
end
