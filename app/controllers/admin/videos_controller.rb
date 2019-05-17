# frozen_string_literal: true

<<<<<<< HEAD
module Admin
  # namespaced videos controller
  class VideosController < Admin::BaseController
    def edit
      @video = Video.find(params[:video_id])
    end

    def update
      video = Video.find(params[:id])
      video.update(video_params)
    end
=======
class Admin::VideosController < Admin::BaseController
>>>>>>> dbd5e46932153cdc79f6b9b4cd8abe8657de42de

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

<<<<<<< HEAD
    def video_params
      params.permit(:position)
    end

    def new_video_params
      params.require(:video).permit(:title, :description, :video_id, :thumbnail)
    end
=======
  def new_video_params
    params.require(:video).permit(:title, :description, :video_id, :thumbnail)
>>>>>>> dbd5e46932153cdc79f6b9b4cd8abe8657de42de
  end
end
