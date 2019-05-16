class Users::FriendsController < ApplicationController
  def create
    new_friend = User.find_by(github_name: params[:login])
    if new_friend
      current_user.friends.create(followed_user_id: new_friend.id)
      flash[:success] = "Successfully added #{params[:login]} as a friend"
      redirect_to dashboard_path
    else
      flash[:error] = "#{params[:login]} is not a valid user"
      redirect_to dashboard_path
    end
  end
end
