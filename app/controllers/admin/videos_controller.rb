# frozen_string_literal: true

class Admin::VideosController < Admin::BaseController
  before_action :tutorial, only: [:create]
  before_action :video_save, only: [:create]

  def edit
    @video = Video.find(params[:video_id])
  end

  def update
    video = Video.find(params[:id])
    video.update(video_params)
  end

  def create
    begin
      flash[:success] = 'Successfully created video.'
    rescue StandardError
      # Sorry about this.
      # We should get more specific instead of swallowing all errors.
      flash[:error] = 'Unable to create video.'
    end

    redirect_to edit_admin_tutorial_path(id: tutorial.id)
  end

  def destroy; end

  private

  def video_params
    params.permit(:position)
  end

  def new_video_params
    params.require(:video).permit(:title, :description, :video_id, :thumbnail)
  end

  def tutorial
    Tutorial.find(params[:tutorial_id])
  end

  def video_save
    thumbnail = YouTube::Video.by_id(new_video_params[:video_id]).thumbnail
    video = tutorial.videos.new(new_video_params.merge(thumbnail: thumbnail))
    video.save
  end
end
