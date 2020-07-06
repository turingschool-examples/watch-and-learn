class FriendshipsController < ApplicationController
  def create
    @friend = User.find_by(handle: params[:non_friend])
    @new_friendship = Friendship.create(friendship_params)
    redirect_to dashboard_path
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end
end
