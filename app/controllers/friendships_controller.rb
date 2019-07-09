class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(html_url: params[:friend_html])
    if !friend.nil?
      Friendship.find_or_create_by(user_id: current_user.id, friend_id: friend.id)
    else
      flash[:message] = "Invalid Friend."
    end
    redirect_to dashboard_path
  end
end
