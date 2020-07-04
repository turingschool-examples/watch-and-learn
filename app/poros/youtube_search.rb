class YoutubeSearch

  def playlist_videos(playlist_id)
    service = YoutubeService.new
    json = service.get_json2(playlist_id)
    json[:items].map do |item|
      {
      thumbnail: item[:snippet][:thumbnails][:default][:url],
      title: item[:snippet][:title],
      video_id: item[:snippet][:resourceId][:videoId],
      description: item[:snippet][:description]
      }
    end
  end
end
