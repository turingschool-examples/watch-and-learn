class FriendshipsController < ApplicationController
  before_action :require_login

  def create
    friendship = Friendship.new(user_id: current_user.id,
                              friend_id: params[:friend_id])
    flash[:error] = "Friendship not created. Invalid id." unless friendship.save
    redirect_to dashboard_path
  end

  private

  def require_login
    flash[:error] = "You must be logged in to perform that action."
    redirect_to login_path unless current_user
  end
end
