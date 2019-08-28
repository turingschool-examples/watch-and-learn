class FriendshipsController < ApplicationController
  def create
    friend = current_user.friendships.create(friendship_params)
    if friend.save
      flash[:notice] = "Friend has been added."
    else
      flash[:alert] = "User does not exist."
    end
    redirect_to dashboard_path
  end

  private

  def friendship_params
    params.permit(:friend_id)
  end
end
