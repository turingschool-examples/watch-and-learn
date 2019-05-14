class FriendshipsController < ApplicationController

  def create
    friend = User.find_by(username: params[:friend])
    # binding.pry
    Friendship.create(user_id: current_user.id, friendship_id: friend.id)
    flash[:notice] = "Added #{friend.username} as a Friend"
    redirect_to dashboard_path
  end

end
