class FriendshipUsersController < ApplicationController
  def create
    user = current_user
    friend = User.find_by(uid: params["format"])
  end
end
