class Admin::ImportPlaylistController < Admin::BaseController

  def new
  end

  def import_playlist
    if params[:id]
      tutorial = Tutorial.create(
        {
          title: params[:title],
          description: params[:description],
          thumbnail: params[:thumbnail],
          playlist_id: params[:id]
        }
      )
      youtube_decorator = YoutubeDecorator.new(tutorial)
      imported_videos = youtube_decorator.playlist_videos(params[:id])

      flash[:notice] = "Successfully created tutorial #{view_context.link_to('View it here', tutorial_path(tutorial))}.".html_safe

      redirect_to admin_dashboard_path
    end
  end
end
