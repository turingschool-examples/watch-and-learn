class FriendshipsController < ApplicationController
  def create
    current_user.friends << User.find_by(github_username: params[:name])
    redirect_to '/dashboard'
  end
end