class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial_from_playlist = Tutorial.create(new_tutorial_params)
    tutorial_from_playlist.create_playlist_videos
    if tutorial_from_playlist.save
      flash[:success] = "Successfully created tutorial. #{view_context.link_to("View it here", tutorial_path(tutorial_from_playlist.id))}."
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

  def new_tutorial_params
    results = YoutubePlaylistResults.new(params[:playlist_id])
    results.parameters
  end

end
