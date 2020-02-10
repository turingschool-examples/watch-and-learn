class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(github_id: params[:github_id])
    Friendship.create(user: current_user, friend_id: friend.id)
    redirect_to '/dashboard'
    flash[:notice] = 'You have a friend.'
  end
end
