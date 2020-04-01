class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(github_username: params['login'])
    if friend
      current_user.friends << friend
      flash[:success] = "New Friend!"
      redirect_to dashboard_path
    else
      flash[:error] = "Invalid ID!"
      redirect_to dashboard_path
    end
  end
end
