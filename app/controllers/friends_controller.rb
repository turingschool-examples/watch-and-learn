class FriendsController < ApplicationController
  def create
    if !User.id_check(params[:user_id]) ||
       !User.github_usernames.include?(params[:github_username])
      redirect_back(fallback_location: root_path)
    else
      friend_id = User.find_by(github_username: params[:github_username]).id
      Friendship.create(user_id: params[:user_id], friend_id: friend_id)
      redirect_to dashboard_path
    end
  end
end
