class UsersFriendsController < ApplicationController
  def update
    name = params[:name]
    current_user.friends << name.sub('-', ' ')
    current_user.save!
    redirect_to dashboard_path
  end
end
