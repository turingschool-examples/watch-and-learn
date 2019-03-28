# class UserVideosController < ApplicationController
#   def new
#   end
#
#   def create
#     user_video = UserVideo.new(user_video_params)
#     if find_bookmark(user_video.video_id)
#       flash[:error] = "Already in your bookmarks"
#     elsif user_video.save
#       flash[:success] = "Bookmark added to your dashboard!"
#     end
#
#     redirect_back(fallback_location: root_path)
#   end
#
#   private
#
#   def user_video_params
#     params.permit(:user_id, :video_id)
#   end
# end
