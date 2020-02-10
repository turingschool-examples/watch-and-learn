class Tutorial < ApplicationRecord

  validates :title, length: { minimum: 5 }
  validates :description, length: { minimum: 10 }

  has_many :videos, -> { order(position: :ASC) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  scope :classroom, -> { where(classroom: false) }
end
