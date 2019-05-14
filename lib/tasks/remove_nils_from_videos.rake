# frozen_string_literal: true

namespace :update do
  desc 'remove nils from video position'
  task videos: :environment do
    Video.all.each do |video|
      if video.position.nil?
        new_position = Video.order(position: :desc).second.position + 1
        video.update(position: new_position)
      end
    end
  end
end
