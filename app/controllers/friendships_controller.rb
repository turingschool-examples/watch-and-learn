class FriendshipsController < ApplicationController

  def create
    new_friend = User.find_by(html_url: params[:new_friend_url])
    # binding.pry
    if !new_friend.nil?
      Friendship.create!(user_id: current_user.id, friend_id: new_friend.id)
      flash[:friend] = "Friend Added!"
    else

    end
    redirect_to dashboard_path
  end
end
