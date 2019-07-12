# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = 'Successfully created friendship'
    else
      flash[:error] = 'Unable to add friend.'
    end
    redirect_to dashboard_path
  end
end
