class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(playlist_params)
    #valid_playlist_id?(tutorial)
    if params[:tutorial][:playlist_id]
      youtube_decorator = YoutubeDecorator.new(tutorial)
      youtube_decorator.playlist_videos(params[:tutorial][:playlist_id])
    
      flash[:notice] = "Successfully created tutorial.
                       #{view_context.link_to('View it here.', tutorial_path(tutorial.id))}."
    end
    redirect_to admin_dashboard_path
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.update(tutorial_params)
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def playlist_params
    params.require(:tutorial).permit(:title, :description, :thumbnail, :playlist_id)
  end

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def valid_playlist_id?(tutorial)
    if params[:tutorial][:playlist_id]
      youtube_decorator = YoutubeDecorator.new(tutorial)
      non_valid_playlist if youtube_decorator[:error]
      youtube_decorator.playlist_videos(params[:tutorial][:playlist_id])

      flash[:notice] = "Successfully created tutorial.
                         #{view_context.link_to('View it here.', tutorial_path(tutorial.id))}."
    end
  end

  def non_valid_playlist
    flash[:error] = "Not a valid Playlist ID"
    redirect_to new_admin_playlist_path
  end
end
