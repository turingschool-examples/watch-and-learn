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
      url = server_origin
      UserMailer.registration_email(user, url).deliver_now
      flash[:success] = "Logged in as #{user.first_name}"
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def github_auth
    current_user.update_attribute(:github_token, github_token)
    current_user.update_attribute(:github_id, github_id)

    redirect_to dashboard_path
  end

  def register_email
    user = User.find(params[:id])
    user.update_attribute(:account_registered, true)
  end

  def invite_guest
  end

  def send_guest_invite
    @facade = UserFacade.new(current_user)

    @facade.find_github_user_data(params["github_handle"])

    UserMailer.registration_email(user, url).deliver_now
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def github_token
    request.env["omniauth.auth"]["credentials"]["token"]
  end

  def github_id
    request.env["omniauth.auth"]["uid"]
  end

  def server_origin
    request.env["HTTP_ORIGIN"]
  end
end
