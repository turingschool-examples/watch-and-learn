class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def fetch_videos_for_playlist(playlist_id)
    videos = playlist_video_info(playlist_id).map do |video|
      { title: video[:snippet][:title],
        description: video[:snippet][:description],
        video_id: video[:id],
        thumbnail: video[:snippet][:thumbnails][:default][:url],
        position: video[:snippet][:position]}
    end
  end

  def playlist_video_info(playlist_id)
    params = { part: 'snippet', playlistId: playlist_id, maxResults: 5 }
    raw_videos = get_json('youtube/v3/playlistItems', params)
   
    next_page = raw_videos[:nextPageToken]
    puts next_page
    while next_page
      puts 'I am here'
      params = { part: 'snippet', playlistId: playlist_id, maxResults: 5, pageToken: next_page}
      raw_videos[:items].push(get_json('youtube/v3/playlistItems', params)[:items])
    end
    raw_videos[:items]
  end
  
  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  private


  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
    end
  end
end
