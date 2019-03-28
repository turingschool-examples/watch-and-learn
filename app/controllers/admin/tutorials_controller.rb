# frozen_string_literal: true

class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.create(tutorial_params)
    if tutorial_params[:playlist_id] != ''
      videos = YouTube::Video.find_playlist_videos(tutorial_params[:playlist_id])
      videos.each do |video|
        tutorial.videos.create(video_id: video.video_id, thumbnail: video.thumbnail, title: video.title, description: video.description, position: video.position)
      end
    end
    flash[:success] = "Successfully created tutorial. #{view_context.link_to 'View It Here.', tutorial_path(tutorial)}"
    redirect_to admin_dashboard_path
  rescue StandardError
    flash[:error] = 'Unable to find playlist you are looking for.'
    redirect_to new_admin_tutorial_path
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

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list, :title, :description, :thumbnail, :playlist_id)
  end
end
