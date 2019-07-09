# frozen_string_literal: true

namespace :video_update do
  desc 'Adds one month to the Look Subscription'
  task update_position: :environment do
    Video.where(position: nil).update_all(position: 0)
    puts "Video positions with nil previous value have been updated to '0'."
  end
end
