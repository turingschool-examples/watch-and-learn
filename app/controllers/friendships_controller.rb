# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(github_id: params[:friend_id])
    current_user.followees << friend
    redirect_to dashboard_path
  end
end
