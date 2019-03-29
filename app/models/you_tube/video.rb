# frozen_string_literal: true

module YouTube
  class Video
    attr_reader :thumbnail,
                :video_id,
                :title,
                :description,
                :position
    def initialize(data = {})
      if data[:items]
        @thumbnail = data[:items].first[:snippet][:thumbnails][:high][:url]
      else
        @thumbnail = data[:snippet][:thumbnails][:high][:url]
        @video_id = data[:contentDetails][:videoId]
        @title = data[:snippet][:title]
        @description = data[:snippet][:description]
        @position= data[:snippet][:position]
      end
    end

    def self.by_id(id)
      new(YoutubeService.new.video_info(id))
    end

    def self.find_playlist_videos(playlist_id)
      videos = YoutubeService.new.playlist_videos(playlist_id)
      videos.map do |video_data|
        new(video_data)
      end
    end
  end
end
