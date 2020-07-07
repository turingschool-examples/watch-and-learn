class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create

    tutorial = Tutorial.new(tutorial_params)
    videos = YoutubeService.new.fetch_videos_for_playlist(playlist_params[:playlists][:playlist_id])
    
    if tutorial.save
      videos.each do |video_info|
        video = Video.create!({tutorial: tutorial}.merge(video_info))
        puts video  
      end
      flash[:success] = "Successfully created tutorial. #{view_context.link_to('View it here.', tutorial_path(tutorial))}"
      redirect_to "/tutorials/#{tutorial.id}"
    else
      flash[:error] = "tutorial not created!"
      redirect_to "/admin/tutorials/new"
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
    params.require(:tutorial).permit(:tag_list, :title, :description, :thumbnail)
  end

  def playlist_params
    params.require(:tutorial).permit(playlists: :playlist_id)
  end
end
