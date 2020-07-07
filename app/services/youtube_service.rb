class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def playlist_info(id, token = nil)
    nilhash = { part: 'contentDetails,snippet', playlistId: id, maxResults: 50 }
    params = if token.nil?
               nilhash
             else
               { part: 'contentDetails,snippet',
                 playlistId: id,
                 maxResults: 50,
                 pageToken: token }
             end
    get_json('youtube/v3/playlistItems', params)
  end

  def get_playlist_token(id, token = nil)
    playlist_info(id, token)[:nextPageToken]
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
