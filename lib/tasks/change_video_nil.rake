# frozen_string_literal: true

namespace :video_position do
  desc "add default position to nil video positions"

  task remove_nil_position: :environment do
    Video.where(position: nil).each do |n|
      n.update_attribute :position, 0
    end
  end
end
