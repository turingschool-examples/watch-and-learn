class Api::V1::BookmarksController < ApplicationController

  def create
    render json: UserVideoSerializer.new(current_user.user_videos.create!(user_video_params))
  end

  private

  def user_video_params
    params.require(:bookmark).permit(:video_id)
  end
end
