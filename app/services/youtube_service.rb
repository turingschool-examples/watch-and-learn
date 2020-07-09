class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)

  end

  def playlist_info(playlist_id)
    get_json2(playlist_id)
  end

  def get_json2(playlist_id)
    response = conn2(playlist_id).get("youtube/v3/playlistItems")
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def get_json(url, params)

    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    stuff = Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
    end
  
  end

  def conn2(playlist_id)
  Faraday.new(url: 'https://www.googleapis.com') do |faraday|
  faraday.params[:part] = "snippet"
  faraday.params[:playlistId] = playlist_id
  faraday.params[:key] = ENV['YOUTUBE_API_KEY']
  end
  #
  # response = conn.get("youtube/v3/playlistItems")
  # parsed = JSON.parse(response.body, symbolize_names: true)
  end
end
