class Admin::VideosController < Admin::BaseController
  def edit
    @video = Video.find(params[:id])
  end

  def update
    video = Video.find(params[:id])
    video.update(video_params)
    
    redirect_to tutorial_path(video.tutorial)
  end

  def create
    begin
      tutorial  = Tutorial.find(params[:tutorial_id])
      thumbnail = YouTube::Video.by_id(video_params[:video_id]).thumbnail
      video     = tutorial.videos.new(video_params.merge(thumbnail: thumbnail))

      video.save

      flash[:success] = "Successfully created video."
    rescue # Sorry about this. We should get more specific instead of swallowing all errors.
      flash[:error] = "Unable to create video."
    end

    redirect_to edit_admin_tutorial_path(id: tutorial.id)
  end

  private
    def video_params
      params.require(:video).permit(:position, :title, :description, :video_id, :thumbnail)
    end
end
