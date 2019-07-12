# frozen_string_literal: true

class Admin::VideosController < Admin::BaseController
  def create
    @tutorial  = Tutorial.find(params[:tutorial_id])
    video      = @tutorial.videos.new(video_params)
    if video.save
      video.get_thumbnail
      flash[:success] = 'Successfully created video.'
      redirect_to edit_admin_tutorial_path(@tutorial)
    else
      redirect_to edit_admin_tutorial_path(@tutorial, params: {video: video.attributes})
    end
  end

  private

  def video_params
    params.require(:video).permit(:title, :description, :video_id, :thumbnail)
  end
end
