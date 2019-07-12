# frozen_string_literal: true

namespace :import do
  desc :"Create Tutorials"
  task :tutorials, [:tutorials] => :environment do
    response = Faraday.get("https://www.googleapis.com/youtube/v3/playlists?ke\
      y=#{ENV['YOUTUBE_API_KEY']}&part=snippet&channelId=UC2zYYOtckevoWTGDu5Sd\
      Ckg&maxResults=50")
    data = JSON.parse(response.body, symbolize_names: true)
    data[:items].each do |tutorial|
      Tutorial.create(
        title: tutorial[:snippet][:title],
        description: tutorial[:snippet][:description],
        thumbnail: tutorial[:snippet][:thumbnails][:high][:url],
        playlist_id: tutorial[:id]
      )
    end
  end
end
