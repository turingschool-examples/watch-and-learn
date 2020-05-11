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
    playlist = service.playlist_info(params[:playlist_id])
    tutorial = Tutorial.create(import_tutorial_params)
    create_tutorial_videos(tutorial, playlist)
    pagination(tutorial, service, playlist)
    flash[:success] = "Successfully created tutorial. #{view_context.link_to('View it here.', tutorial_path(tutorial.id))}"
    redirect_to admin_dashboard_path
  end

  private

  def create_tutorial_videos(tutorial, playlist)
    playlist[:items].each do |video|
      tutorial.videos.create(video_params(video))
    end
  end

  def pagination(tutorial, service, playlist)
    until playlist[:nextPageToken].nil?
      playlist = service.next_page(params[:playlist_id], playlist)
      create_tutorial_videos(tutorial, playlist)
    end
  end

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def import_tutorial_params
    params.permit(:title, :description, :thumbnail, :playlist_id)
  end

  def video_params(video)
    title = video[:snippet][:title]
    description = video[:snippet][:description]
    video_id = video[:id]
    thumbnail = video[:snippet][:thumbnails][:high][:url]
    { description: description,
      title: title,
      video_id: video_id,
      thumbnail: thumbnail }
  end
end
