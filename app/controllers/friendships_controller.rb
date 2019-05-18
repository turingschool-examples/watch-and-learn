# frozen_string_literal: true

# friendship controller
class FriendshipsController < ApplicationController
  before_action :active_current_user?
  def create
    friend = User.find_by(username: params[:friend])
    Friendship.create(user_id: current_user.id, friendship_id: friend.id)
    flash[:notice] = "Added #{friend.username} as a Friend"
    redirect_to dashboard_path
  end
end
