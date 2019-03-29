# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    if current_user && !current_user.github_token
      current_user.update(uid: request.env['omniauth.auth']['uid'])
      if User.find(current_user.id).uid
        current_user.update(github_token: request.env['omniauth.auth']['credentials']['token'])
        current_user.update(github_username: request.env['omniauth.auth']['extra']['raw_info']['login'])
        redirect_to dashboard_path
      else
        flash[:error] = "This GitHub account is already connected to another user's profile"
        redirect_to dashboard_path
      end
    else
      user = User.find_by(email: params[:session][:email])
      if user&.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to dashboard_path
      else
        flash[:error] = 'Looks like your email or password is invalid'
        render :new
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
