class User::FriendshipsController < ApplicationController

  def create
    current_user.friendships.create!(user_id: params["id"], friend_id: params["friend_id"])
    friend_user = User.find(params["friend_id"])
    friend_user.friendships.create!(user_id: params["friend_id"], friend_id: params["id"])
    redirect_to "/dashboard"
  end
end
