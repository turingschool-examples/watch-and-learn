class YoutubePlaylistResults
  def initialize(playlist_id)
    @id = playlist_id
  end

  def parameters
    parameters = {}
    parameters[:title] = snippet[:title]
    parameters[:description] = snippet[:description]
    parameters[:thumbnail] = snippet[:thumbnails][:default][:url]
    parameters[:playlist_id] = @id
    parameters
  end

  def snippet
    return nil if playlist[:items].blank?

    playlist[:items][0][:snippet]
  end

  def playlist
    YoutubeService.new.playlist_info(@id)
  end
end
