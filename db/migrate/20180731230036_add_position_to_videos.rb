# frozen_string_literal: true

# this migration adds a column to the videos table
class AddPositionToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :position, :integer, default: 0
  end
end
