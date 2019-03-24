class FriendsController < ApplicationController
  def create
    begin
      friend_user = User.find_by_uid(params[:friend_uid])
      Friend.create(user: current_user, friend_user: friend_user)
    rescue
      flash[:error] = "Unable to add user as a friend. Please try again."
    end
    redirect_to dashboard_path
  end
end
