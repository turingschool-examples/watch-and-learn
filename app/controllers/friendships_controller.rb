class FriendshipsController < ApplicationController
  def create
    friend_id = User.find_by(github_login: params[:friend_login]).id
    Friendship.create!(user_id: params[:user_id], friend_id: friend_id, friend_login: params[:friend_login])
    redirect_to dashboard_path
  end
end
