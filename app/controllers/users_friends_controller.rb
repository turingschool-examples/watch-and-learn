class UsersFriendsController < ApplicationController
  def update
    current_user.friends << params[:name]
    current_user.save!
    redirect_to dashboard_path
  end
end
