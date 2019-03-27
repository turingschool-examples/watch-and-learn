class FriendshipsController < ApplicationController
  def create
    friend = User.where(uid: params[:friend]).first
    friendship = current_user.friendships.new(friend: friend)

    if friendship.save

      flash[:success] = "#{friend.first_name} added as a friend."
    else
      flash[:error] = "Invalid friend request"
    end

    redirect_to dashboard_path
  end
end
