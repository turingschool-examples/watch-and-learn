class FriendshipsController < ApplicationController

  def create
    new_friend = User.find_by(html_url: params[:new_friend_url])
    if !new_friend.nil?
      Friendship.create!(user_id: current_user.id, friend_id: new_friend.id)
      flash[:friend] = "Friend Added!"
    end
    redirect_to dashboard_path
  end
end
