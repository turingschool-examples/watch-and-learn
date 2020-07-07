class FriendsController < ApplicationController
  def create
    friend_id = User.find_by(github_username: params[:github_username]).id
    Friendship.create(user_id: params[:user_id], friend_id: friend_id)
    redirect_to dashboard_path
  end
end
