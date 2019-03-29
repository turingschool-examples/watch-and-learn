# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @new ||= User.new
  end

  def create
    if current_user && !current_user.github_token
      connect_to_github
      redirect_to dashboard_path
    else
      login_user
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def connect_to_github
    current_user.update(uid: request.env['omniauth.auth']['uid'])
    if User.find(current_user.id).uid
      assign_token_and_username
    else
      # rubocop:disable Metrics/LineLength
      flash[:error] = "This GitHub account is already connected to another user's profile"
      # rubocop:enable Metrics/LineLength
    end
  end

  def login_user
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def assign_token_and_username
    # rubocop:disable Metrics/LineLength
    current_user.update(github_token: request.env['omniauth.auth']['credentials']['token'])
    current_user.update(github_username: request.env['omniauth.auth']['extra']['raw_info']['login'])
    # rubocop:enable Metrics/LineLength
  end
end
