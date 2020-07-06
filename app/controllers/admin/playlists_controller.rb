class Admin::PlaylistsController < Admin::BaseController
  def new 

  end

  def create
    playlist = YoutubeService.new.playlist(params[:playlist_id])
    tutorial = Tutorial.create(title: playlist[:items].first[:snippet][:title],
                            description: playlist[:items].first[:snippet][:description],
                            thumbnail: playlist[:items].first[:snippet][:thumbnails][:default][:url],
                            playlist_id: params[:playlist_id])

    tutorial_videos = YoutubeService.new.playlist_items(params[:playlist_id], tutorial)

    redirect_to '/admin/dashboard?tutorial=create'
  end
end