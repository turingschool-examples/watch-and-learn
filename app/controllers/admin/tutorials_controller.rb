class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    if results.snippet.nil?
      flash[:error] = 'Sorry, that ID is not valid. Try again?'
      redirect_to new_admin_youtube_playlist_path
    else
      tutorial_from_playlist = Tutorial.create(new_tutorial_params)
      tutorial_from_playlist.create_playlist_videos
      context = view_context.link_to('View it here', tutorial_path(tutorial_from_playlist.id))
      flash[:success] = "Successfully created tutorial. #{context}."
      redirect_to admin_dashboard_path
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    flash[:success] = "#{tutorial.title} tagged!" if tutorial.destroy
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def results
    YoutubePlaylistResults.new(params[:playlist_id])
  end

  def new_tutorial_params
    results.parameters
  end
end
