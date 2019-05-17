# frozen_string_literal: true

module Admin
  # namespaced controller for admin/videos
  class VideosController < Admin::BaseController
    def create
      begin
        tutorial = Tutorial.find(params[:tutorial_id])
        setup(tutorial)
      rescue StandardError
        # Sorry about this. We should get more specific
        # instead of swallowing all errors.
        flash[:error] = 'Unable to create video.'
      end
      redirect_to edit_admin_tutorial_path(id: tutorial.id)
    end

    def setup(tutorial)
      thumbnail = YouTube::Video.by_id(new_video_params[:video_id]).thumbnail
      video     = tutorial.videos.new(new_video_params
                          .merge(thumbnail: thumbnail))
      video.save
      flash[:success] = 'Successfully created video.'
    end

    private

    def new_video_params
      params.require(:video).permit(:title, :description, :video_id, :thumbnail)
    end
  end
end
