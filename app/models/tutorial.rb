# frozen_string_literal: true

# == Schema Information
#
# Table name: tutorials
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  thumbnail   :string
#  playlist_id :string
#  classroom   :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
end
