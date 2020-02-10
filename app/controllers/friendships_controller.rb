class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(github_id: params[:github_id])
    current_user.friends << friend
    redirect_to '/dashboard'
    flash[:notice] = 'You have a friend.'
  end
end
