class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create; end

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

  def import; end

  def new_import
    service = YoutubeService.new
    videos = service.playlist_info(params[:playlist_id])
    tutorial = Tutorial.create(import_tutorial_params)
    videos.each do |video|
      title = video[:items].first[:snippet][:title]
      description = video[:items].first[:snippet][:description]
      video_id = video[:items].first[:id]
      thumbnail = video[:items].first[:snippet][:thumbnails][:high][:url]
      video_params = {description: description, title: title, video_id: video_id, thumbnail: thumbnail}

      video = tutorial.videos.create(video_params)
    end
    flash[:success] = "Successfully created tutorial. #{view_context.link_to('View it here.', tutorial_path(tutorial.id))}"
    redirect_to admin_dashboard_path
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def import_tutorial_params
    params.permit(:title, :description, :thumbnail, :playlist_id)
  end
end
