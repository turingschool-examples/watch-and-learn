class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = 'Added Friend!'
      redirect_to dashboard_path
    else
      flash[:error] = 'Failed to Add Friend!'
      redirect_to dashboard_path
    end
  end

end