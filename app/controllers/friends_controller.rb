class FriendsController < ApplicationController

  def update
    current_user.friends << User.find_by(github_username: params[:github_username])
    redirect_to dashboard_path
  end
end
