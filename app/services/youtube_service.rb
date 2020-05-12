class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def playlist(id)
    params = { part: 'snippet,contentDetails',
               playlistId: id,
               maxResults: 50 }

    get_playlist('youtube/v3/playlistItems', params)
  end

  private

  def get_playlist(url, params)
    vid_list = []

    loop do
      json = get_json(url, params)
      params[:pageToken] = json[:nextPageToken]
      vid_list << json[:items]
      break if json[:nextPageToken].nil?
    end

    vid_list.flatten
  end

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
