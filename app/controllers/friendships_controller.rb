class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(username: params[:friend_username])
    Friendship.create({user_id: current_user.id, friend_id: friend.id})
    redirect_to dashboard_path
  end
end
