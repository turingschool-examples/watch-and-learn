# frozen_string_literal: true
class FriendshipsController < ApplicationController
  def create
    if User.find_by(uid: params[:uid])
      current_user.friends << User.find_by(uid: params[:uid])
      redirect_to dashboard_path
    else
      redirect_to dashboard_path
      flash[:notice] = 'There was an error adding a friend'
    end
  end
end
