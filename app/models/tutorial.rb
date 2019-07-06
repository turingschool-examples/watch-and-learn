# frozen_string_literal: true

class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.filtered(user)
    if !user
      Tutorial.where(classroom: false)
    else
      Tutorial.all
    end
  end
end
