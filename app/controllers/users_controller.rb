# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    if current_user.github_token?
      @facades = UserFacade.new(current_user)
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      NewUserNotifierMailer.registration_email(user, user.email.deliver_now)
      redirect_to dashboard_path
      flash[:success] = "Logged in as #{user.first_name}"
      flash[:notice] = "This account has not yet been activated. Please check your email"
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def github_auth
    current_user.update_attribute(:github_token, github_token)
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def github_token
    request.env["omniauth.auth"]["credentials"]["token"]
  end
end
