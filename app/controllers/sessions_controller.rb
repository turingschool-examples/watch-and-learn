# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def update
    current_user.update(github_token: auth_github_token, github_username: auth_github_username)
    redirect_to '/dashboard'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def auth_github_token
    request.env['omniauth.auth']['credentials']['token']
  end

  def auth_github_username
  request.env['omniauth.auth']['info']['nickname']
  end
end
