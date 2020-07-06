class YoutubeService
  
  def playlist(id)
    params = { part: 'snippet', id: id }

    get_json('youtube/v3/playlists', params)
  end

  def playlist_items(id, tutorial)
    params = { part: 'snippet', playlistId: id, maxResults: 50 }

    response = get_json('youtube/v3/playlistItems', params)
    response[:items].each_with_index do |item, index|
      tutorial.videos.create(title: item[:snippet][:title], 
        description: item[:snippet][:description], 
        video_id: item[:snippet][:resourceId][:videoId],
        thumbnail: item[:snippet][:thumbnails][:default][:url],
        tutorial_id: tutorial.id,
        position: index)
      end
  end

  # def playlist_items_with_thumbnail(id, tutorial)
    
  #   params = { part: 'snippet', thumbnails: id, maxResults: 50 }

  #   response = get_json('youtube/v3/playlistItems', params)
   

  #   response[:items].each_with_index do |item, index|
  #   end
  # end

  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
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
