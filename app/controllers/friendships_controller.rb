class FriendshipsController < ApplicationController
  def create
    friendship = current_user.friendships.build(friend_id: params[:id])
    if friendship.save
      flash[:notice] = 'Added friend!'
    else
      flash[:error] = 'Unable to friend user.'
    end
    redirect_to dashboard_path
  end
end
