class FriendshipsController < ApplicationController
  def create
    user = User.find_by(github_username: params[:name])
    if user
      current_user.friends << user
    else
      flash[:error] = "Invalid Friend"
    end
    redirect_to '/dashboard'
  end
end
