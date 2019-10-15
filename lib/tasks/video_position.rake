namespace :videos_db do
  desc "No videos with nil position"

  task :change_position => :environment do
    videos = Video.all
    videos.each.with_index(1) do |video, index|
      video.update_attribute(:position, index)
    end
  end
end
