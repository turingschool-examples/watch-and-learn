class YoutubeDecorator
  def initialize(tutorial)
    @tutorial = tutorial
    create_youtube_service
  end

  def create_youtube_service
    @youtube_service = YoutubeService.new
  end

  def playlist_videos(playlist_id)
    videos_info = get_videos_info(playlist_id)
    videos = create_videos(videos_info)
  end

  def get_videos_info(playlist_id)
    videos_info = []
    playlist_items = @youtube_service.playlist_items(playlist_id)

    playlist_items[:items].each do |playlist_item|
      playlist_item_info = {}
      playlist_item_info[:title] = playlist_item[:snippet][:title]
      playlist_item_info[:description] = playlist_item[:snippet][:description]
      playlist_item_info[:video_id] = playlist_item[:contentDetails][:videoId]
      playlist_item_info[:thumbnail] = playlist_item[:snippet][:thumbnails][:default][:url]
      videos_info << playlist_item_info
    end

    if playlist_items[:nextPageToken]
      next_page_token = playlist_items[:nextPageToken]

      until next_page_token == nil
        playlist_items = @youtube_service.playlist_items(playlist_id, next_page_token)

        playlist_items[:items].each do |playlist_item|
          playlist_item_info = {}
          next if playlist_item[:snippet][:title] == "Private video"
          playlist_item_info[:title] = playlist_item[:snippet][:title]
          playlist_item_info[:description] = playlist_item[:snippet][:description]
          playlist_item_info[:video_id] = playlist_item[:contentDetails][:videoId]
          playlist_item_info[:thumbnail] = playlist_item[:snippet][:thumbnails][:default][:url]
          videos_info << playlist_item_info
        end

        if playlist_items[:nextPageToken]
          next_page_token = playlist_items[:nextPageToken]
        else
          next_page_token = nil
        end
      end
    end
    videos_info
  end

  def create_videos(videos_info)
    position_counter = -1
    videos_info.map do |video_info|
      position_counter +=1
      formatted_video_info = format_video_info(video_info, position_counter)
      @tutorial.videos.create(formatted_video_info)
    end
  end

  def format_video_info(video_info, position_counter)
    {
          title: video_info[:title],
          description: video_info[:description],
          video_id: video_info[:video_id],
          thumbnail: video_info[:thumbnail],
          position: position_counter
    }
  end

end
