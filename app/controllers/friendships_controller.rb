class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.create(friend_id: params[:friends])
      if @friendship.save
        flash[:notice] = "Added friend."
        redirect_to dashboard_path
      else
        flash[:error] = "Unable to add friend."
        redirect_to dashboard_path
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Friend removed."
    redirect_to dashboard_path
  end

end
