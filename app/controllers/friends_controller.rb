class FriendsController < ApplicationController

  def update
    current_user.friends << User.find_by(github_username: params[:github_username])
    current_user.save
    redirect_to dashboard_path
  end
end
# def create
#   @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
#   if @friendship.save
#     flash[:notice] = "Added friend."
#     redirect_to root_url
#   else
#     flash[:notice] = "Unable to add friend."
#     redirect_to root_url
#   end
# end
