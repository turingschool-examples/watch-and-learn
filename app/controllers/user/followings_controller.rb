class User::FollowingsController < ApplicationController

  def create
    current_user.followings.create!(user_id: params["id"], followed_user_id: params["friend_id"])
    friend_user = User.find(params["friend_id"])
    friend_user.followings.create!(user_id: params["friend_id"], followed_user_id: params["id"])
    redirect_to "/dashboard"
  end
end
