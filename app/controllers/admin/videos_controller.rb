class Admin::VideosController < Admin::BaseController
  def edit
    @video = Video.find(params[:video_id])
  end

  def update
    video = Video.find(params[:id])
    video.update(reposition_video_params)
  end

  def create
    flash[:success] = "Successfully created video." if tutorial_video.save
    flash[:error] = "Unable to create video."   unless tutorial_video.save
    redirect_to edit_admin_tutorial_path(id: find_tutorial.id)
  end

  private

  def tutorial_video
    @_video ||= find_tutorial.videos.new(new_video_params.merge(
                                      thumbnail:find_thumbnail))
  end

  def find_thumbnail
    @_thumbnail ||= YouTube::Video.by_id(new_video_params[:video_id]).thumbnail
  end

  def find_tutorial
    @_tutorial ||= Tutorial.find(params[:tutorial_id])
  end

  def reposition_video_params
    params.permit(:position)
  end

  def new_video_params
    params.require(:video).permit(:title, :description, :video_id, :thumbnail)
  end
end
