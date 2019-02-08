class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friends])
    if @friendship.save
      flash[:notice] = "Added friend: #{@friendship.friend.first_name}"
      redirect_to dashboard_path
    else
      flash[:notice] = "Unable to add friend."
      redirect_to dashboard_path
    end
  end

  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    if @friendship.present?
      @friendship.destroy
      flash[:notice] = "Friend removed."
    else
      flash[:notice] = "This folk is not your buddy"
    end
    redirect_to dashboard_path
  end

end
