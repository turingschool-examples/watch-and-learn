# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @facades = UserFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      UserMailer.registration_email(user, server_origin).deliver_now
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

    guest = @facade.find_github_user_data(params["github_handle"])

    if guest.not_exist?
      flash[:error] = "The GitHub username you have entered is invalid."
      redirect_to invite_path
    elsif guest.email?
      UserMailer.invite_guest(current_user, guest, server_origin).deliver_now
      redirect_to dashboard_path
      flash[:success] = "Successfully sent invite!"
    else
      redirect_to dashboard_path
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
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
    #was calling "HTTP_ORIGIN". May need to fix in production
    request.env["HTTP_HOST"]
  end
end
