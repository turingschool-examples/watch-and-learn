class FriendshipsController < ApplicationController

  def create
    new_friend = User.find_by(html_url: params[:new_friend_url])
    if !new_friend.nil?
      friendship = Friendship.new(user_id: current_user.id, friend_id: new_friend.id)
      if friendship.save
        flash[:friend] = "Friend Added!"
      else
      flash[:friend_error] = "Friend not added!"
      end
    end
    redirect_to dashboard_path
  end
end
