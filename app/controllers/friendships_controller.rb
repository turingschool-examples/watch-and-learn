class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:success] = 'Added Friend!'
    else
      flash[:error] = 'Failed to Add Friend!'
    end
    redirect_to dashboard_path
  end
end
