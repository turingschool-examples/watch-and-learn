class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:user])
    friend = User.where(uid: params[:friend]).first

    Friendship.create(user: user, friend: friend)

    flash[:success] = "#{friend.first_name} added as a friend."
    redirect_to dashboard_path
  end
end
