desc 'Change video position from nil to 0'
task :set_position => [:environment] do
  videos = Video.where(position: nil)

  puts "Going to update #{videos.count} videos"

  videos.each do |video|
    video.position = 0
    video.save
  end

  puts 'All done now!'
end
