class FriendshipsController < ApplicationController
  def new

  end

  def create
    friended_user = User.find_by(github_id: params["friendship"]["friended_user_git_id"])
    Friendship.create(user_id: params["friendship"]["user_id"], friended_user_id: friended_user.id)
    redirect_to dashboard_path
  end
end
