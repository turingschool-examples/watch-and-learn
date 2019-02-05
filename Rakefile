# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks
desc "take any videos with position of 0 and give them incrementing positions"
task video_positions: :environment do
  videos = Video.where(position: 0)
  count = videos.count
  videos.each do |video|
    tutorial = video.tutorial
    max_position = tutorial.videos.max_by{|video| video.position}.position
    video.update(position: max_position + 1 )
  end
  puts "#{count} videos updated!"
end
