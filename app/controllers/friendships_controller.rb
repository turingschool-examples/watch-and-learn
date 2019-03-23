class FriendshipsController < ApplicationController
  def create
    current_user.friends << User.find_by(uid: params[:uid])
    redirect_to dashboard_path
  end
end
