class FriendshipsController < ApplicationController

  def create
    friend = User.find_by(handle: params['handle'])
    current_user.friends << friend
    redirect_to dashboard_path
    end
  end
