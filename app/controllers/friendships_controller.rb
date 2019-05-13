class FriendshipsController < ApplicationController
  def create
    begin
      friend_id = User.find_by(github_login: params[:friend_login]).id
      current_user.friendships << Friendship.create!(user_id: current_user.id, friend_id: friend_id, friend_login: params[:friend_login])
      flash[:success] = "You are now friends with #{params[:friend_login]}"
    rescue
      flash[:error] = "Invalid input"
    end
    redirect_to dashboard_path
  end
end
