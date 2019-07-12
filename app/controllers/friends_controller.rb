# frozen_string_literal: true

class FriendsController < ApplicationController
  def update
    user = User.find_by(github_username: params[:github_username])
    current_user.friendships << user
    redirect_to dashboard_path
  end
end
