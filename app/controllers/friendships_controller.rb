class FriendshipsController < ApplicationController
  def create
    friendship = current_user.friendships.new(friend_id: params[:friend].to_i)
    unless friendship.save
      flash[:error] = "Error: Unable to add friend"
    end
    redirect_to dashboard_path
  end
end
