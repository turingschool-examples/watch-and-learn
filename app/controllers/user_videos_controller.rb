class UserVideosController < ApplicationController
  def new
  end

  def create
    create_catch_duplicate_if_duplicate
    create_succeed_if_successful
    redirect_back(fallback_location: root_path)
  end

  private

  def create_succeed_if_successful
    if !current_user_videos && user_video.save
      flash[:success] = "Bookmark added to your dashboard!"
    end
  end

  def create_catch_duplicate_if_duplicate
    if current_user_videos
      flash[:error] = "Already in your bookmarks"
    end
  end

  def user_video_params
    params.permit(:user_id, :video_id)
  end

  def current_user_videos
    current_user.user_videos.find_by(video_id: user_video.video_id)
  end

  def user_video
    @user_video = UserVideo.new(user_video_params)
  end
end
