class FriendshipsController < ApplicationController
  def create
    friend_id = User.find_by(github_login: params[:friend_login]).id
    current_user.friendships << Friendship.create!(user_id: current_user.id, friend_id: friend_id, friend_login: params[:friend_login])
    redirect_to dashboard_path
  end
end
