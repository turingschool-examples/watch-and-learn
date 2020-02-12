class FriendshipUsersController < ApplicationController
  def create
    user = current_user
    friend = User.find_by(uid: params["format"])
    if friend
      user.frienders << friend
      flash[:success] = "You have added a friend."
    else
      flash[:error] = "Sorry we were not able to find your friend."
    end 
    redirect_to dashboard_path
  end
end
