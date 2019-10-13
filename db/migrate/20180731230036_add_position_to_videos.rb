# frozen_string_literal: true

class AddPositionToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :position, :integer, default: nil
  end
end
