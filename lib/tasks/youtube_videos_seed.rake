# frozen_string_literal: true

namespace :import do
  desc :"Create Videos"
  task :videos, [:videos] => :environment do
    tutorials = Tutorial.all
    tutorials.each do |tutorial|
      response = Faraday.get("https://www.googleapis.com/youtube/v3/playlistIt\
        ems?key=#{ENV['YOUTUBE_API_KEY']}&playlistId=#{tutorial.playlist_id}&p\
        art=snippet&maxResults=50&order=date")
      data = JSON.parse(response.body, symbolize_names: true)
      data[:items].each.with_index(1) do |vid, index|
        tutorial.videos.create!(
          title: vid[:snippet][:title],
          description: vid[:snippet][:description],
          thumbnail: vid[:snippet][:thumbnails][:high][:url],
          video_id: vid[:snippet][:resourceId][:videoId],
          position: index
        )
      end
    end
  end
end
