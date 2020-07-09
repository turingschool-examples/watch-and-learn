class GithubSessionsController < ApplicationController

  def create

    user = current_user
    info = request.env["omniauth.auth"]

    current_user.uid = info.uid
    current_user.username = info.info.nickname
    current_user.token = info.credentials.token
    current_user.save
    session[:user_id] = current_user.id
    flash[:notice] = "Connected to Github"
      redirect_to "/dashboard"
    end
  end
