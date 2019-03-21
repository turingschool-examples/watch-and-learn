namespace :video_position_set do

  task :set_nil_to_default_position => :environment do
    nil_positions = Video.where(position: nil)
    nil_positions.each do |video|
      video.update(position: 0)
    end
    puts 'Set all videos with a nil position to 0'
  end
end
