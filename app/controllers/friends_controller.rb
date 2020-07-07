class FriendsController < ApplicationController
  def create
    # require "pry"; binding.pry
    if !User.pluck(:id).include?(params[:user_id].to_i) ||
       !User.github_usernames.include?(params[:github_username])
      # flash[:notice] = "You cannot add as a Friend"
      redirect_back(fallback_location: root_path)
      # require "pry"; binding.pry
      # redirect_to root_path, flash: {notice: "You cannot add as a Friend"}
    else
      friend_id = User.find_by(github_username: params[:github_username]).id
      Friendship.create(user_id: params[:user_id], friend_id: friend_id)
      redirect_to dashboard_path
    end
  end
end
