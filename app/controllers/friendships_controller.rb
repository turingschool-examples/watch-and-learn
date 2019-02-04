class FriendshipsController < ApplicationController
  def create
    Friendship.create(user_id: current_user.id, friend_id: params[:friend_id])
    redirect_to dashboard_path
  end
end
