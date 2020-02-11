class FriendshipsController < ApplicationController
  def update
    friend = User.find_by(github_id: params[:friend_id])
    current_user.followees << friend
    redirect_to dashboard_path
  end
end
