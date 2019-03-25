class FriendshipsController < ApplicationController
  def create
    binding.pry
    friend = User.find_by(github_uid: params['friend_github_uid'])
    Friendship.create!(user_id: current_user.id, friend_user_id: friend.id)
    redirect_to dashboard_path
  end
end
