class FriendshipsController < ApplicationController
  def create
    binding.pry
    user = User.find_by(uid: params[:uid])
    @friendship = current_user.friendships.create!(friend_id: user.id)
    if @friendship.save
      flash[:notice] = "Added friend."
    else
      flash[:error] = "Unable to add friend."
    end
    binding.pry
    redirect_to "/dashboard"
  end
end
