class UserVideosController < ApplicationController
  before_action :require_login

  def new
  end

  def create
    user_video = current_user.user_videos.new(user_video_params)
    if current_user.user_videos.find_by(video_id: user_video.video_id)
      flash[:error] = "Already in your bookmarks"
    elsif user_video.save
      flash[:success] = "Bookmark added to your dashboard!"
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def user_video_params
    params.permit(:video_id)
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to bookmark a video."
      redirect_to login_path
    end
  end
end
