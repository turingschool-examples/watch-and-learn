class FriendsController < ApplicationController

  def create

    user_friend = User.find(params[:user_id])
    friend = Friend.create(user_id: current_user.id, user_friend_id: params[:user_id])
    binding.pry
    redirect_to dashboard_path
  end

  private
  def friend_params
    params.permit(user_id: current_user.id, user_friend_id: params[:user_id])
  end
end
