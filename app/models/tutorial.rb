class Tutorial < ApplicationRecord
  validates :title, presence: true, length: {minimum: 1}
  validates :description, presence: true, length: {minimum: 0}
  validates :thumbnail, presence: true, length: {minimum: 1}
  has_many :videos, ->  { order(position: :ASC) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
end
