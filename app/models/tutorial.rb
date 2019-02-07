class Tutorial < ApplicationRecord
  has_many :videos, ->  { order(position: :ASC) }
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def update_positions
    if has_position_zero?
      update_positions
    end
  end

  def has_position_zero?
    videos.any?(){'position = 0'}
  end

  def update_positions
    max_position = videos.maximum(:position)
    videos.where('position=?', 0).each do |video|
      max_position += 1
      video.update(position: max_position)
    end
  end
end
