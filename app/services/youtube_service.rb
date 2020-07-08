class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }
    get_json('youtube/v3/videos', params)
  end

  def playlist_info(id)
    params = { part: 'snippet,contentDetails', playlistId: id, maxResults: 50}
 
     raw_videos= get_json('youtube/v3/playlistItems', params)
       next_page = raw_videos[:nextPageToken]
    while next_page
      params = { part: 'snippet, contentDetails', playlistId: id, maxResults: 50, pageToken: next_page }
      temp_videos = get_json('youtube/v3/playlistItems', params)
      temp_videos[:items].each do |item|
        raw_videos[:items].push(item)
      end
      next_page = temp_videos[:nextPageToken]
    end
    raw_videos[:items]
  end
 

  private

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
    end
  end
end
