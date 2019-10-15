class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(github_id: params["friend_id"])

    friendship = Friendship.create({ user_id: params[:user_id],
                                     friendship_user_id: friend.id})

    redirect_to dashboard_path
  end
end
