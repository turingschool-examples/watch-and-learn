class Api::V1::BookmarksController < ApplicationController
  def create
    binding.pry
    if current_user
      video = Video.find(params[:id])
      user_video = current_user.user_videos.new(video: video)
      if find_bookmark(user_video.video_id)
        render json: {message: "Video is already in your bookmarks."}
      elsif user_video.save
        render json: {message: "Bookmark added to your dashboard!"}
      end
    else
      render json: {message: "User must login to bookmark videos."}
    end
  end
end
