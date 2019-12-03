class Admin::VideosController < Admin::BaseController
  def edit
    @video = Video.find(params[:video_id])
  end

  def update
    video = Video.find(params[:id])
    video.update(video_params)
  end

  def create
    begin
      get_video(params[:tutorial_id], new_video_params).save

      flash[:success] = "Successfully created video."
    rescue # Sorry about this. We should get more specific instead of swallowing all errors.
      flash[:error] = "Unable to create video."
    end

    redirect_to edit_admin_tutorial_path(id: params[:tutorial_id])
  end

  private

  def video_params
    params.permit(:position)
  end

  def new_video_params
    params.require(:video).permit(:title, :description, :video_id, :thumbnail)
  end

  def get_video(tutorial_id, new_video_params)
    tutorial  = Tutorial.find(tutorial_id)
    thumbnail = YouTube::Video.by_id(new_video_params[:video_id]).thumbnail
    tutorial.videos.new(new_video_params.merge(thumbnail: thumbnail))
  end
end
