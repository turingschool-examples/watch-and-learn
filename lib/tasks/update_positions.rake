# frozen_string_literal: true

namespace :videos do
  desc 'Updating Video Positions!'
  task update_positions: :environment do
    Video.all.each do |video|
      if video.position.nil?
        video.position = 1
        video.save
      end
    end
    puts 'All Videos with a nil position have been updated'
  end
end
