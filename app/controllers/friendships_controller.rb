# frozen_string_literal: true

class FriendshipsController < ApplicationRecord
  def create

    friend = current_user.friendships.build(friend_id: params[:id].to_i)
    if friend.save
      redirect_to dashboard_path
    else
      flash[:error] = "Something happen please retry!!"
      redirect_to dashboard_path
    end
  end
end
