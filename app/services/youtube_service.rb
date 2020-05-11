class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def playlist(id)
    params = { part: 'snippet,contentDetails',
               playlistId: id,
               maxResults: 50 }
    
    json = get_json('youtube/v3/playlistItems', params)
    vid_list = json[:items]
    
    if json[:nextPageToken]
      params = { part: 'snippet,contentDetails',
                 playlistId: id,
                 maxResults: 50,
                 pageToken: json[:nextPageToken] }
      vid_list << get_json('youtube/v3/playlistItems', params)[:items]
    end
    
    vid_list.flatten
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
