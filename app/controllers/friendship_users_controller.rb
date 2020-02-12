class FriendshipUsersController < ApplicationController
  def create
    user = current_user
    friend = User.find_by(uid: params["format"])
    user.frienders << friend

    flash[:success] = "You have added a friend."
    redirect_to dashboard_path
  end
end
