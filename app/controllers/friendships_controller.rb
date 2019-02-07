class FriendshipsController < ApplicationController
  def create
    user = User.find_by(github_username: params[:name])
    user ? current_user.friends << user : flash[:error] = "Invalid Friend"
    redirect_to '/dashboard'
  end
end
