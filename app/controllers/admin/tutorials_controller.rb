class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    if check_thumbnail(params[:tutorial][:thumbnail])
      return
    else
    tutorial = Tutorial.create(playlist_params)
    if params[:tutorial][:playlist_id]
      non_valid_playlist if create_playlist(params, tutorial).nil?
    else
      redirect_to "/tutorials/#{tutorial.id}?id=#{tutorial.id}"
    end
  end
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

  def create_playlist(params, tutorial)
    youtube_decorator = YoutubeDecorator.new(tutorial)
    return if youtube_decorator.playlist_videos(params[:tutorial][:playlist_id]).nil?
    flash[:notice] = "Successfully created tutorial.
                     #{view_context.link_to('View it here.', tutorial_path(tutorial.id))}."

    redirect_to admin_dashboard_path
  end

  def non_valid_playlist
    flash[:error] = 'Not a valid Playlist ID'
    redirect_to new_admin_playlist_path
  end

  def check_thumbnail(params)
    if /.(jpg|gif|png)/.match(params)
      return
    else
      flash[:error] = "Not a valid thumbnail"
      redirect_to new_admin_tutorial_path
    end
  end
end
