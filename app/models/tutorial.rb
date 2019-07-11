# frozen_string_literal: true

class Tutorial < ApplicationRecord
  validates_presence_of :title, :description, :thumbnail

  has_many :videos, -> { order(position: :ASC) }
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.non_classroom
    where(classroom: false)
  end
end
