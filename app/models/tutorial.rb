class Tutorial < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :thumbnail
  validates_presence_of :description
  validate :thumbnail_is_a_link


  has_many :videos, ->  { order(position: :ASC) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def self.no_classroom_content
    Tutorial.where(classroom: false)
  end

  private

  def thumbnail_is_a_link
    unless thumbnail && thumbnail[/\Ahttp/]
      errors.add(:thumbnail, "must be a valid link")
    end
  end
end
