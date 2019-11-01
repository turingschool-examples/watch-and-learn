# frozen_string_literal: true

class FriendshipsController < ApplicationRecord
  def create
    current_user.friendships.create!(friend_id: params[:id].to_i)
    redirect_to dashboard_path
  end
end
