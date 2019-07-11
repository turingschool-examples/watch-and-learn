# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    render locals: {
      facade: UserDashboardFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      session[:user_id] = @user.id
      flash[:message] = "Logged in as #{@user.first_name}"
      flash[:success] = 'This account has not yet been activated. Please check your email.'
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def update
    token = request.env['omniauth.auth']['credentials']['token']
    nickname = request.env['omniauth.auth']['info']['nickname']
    current_user.update_attribute(:github_username, nickname)
    current_user.update_attribute(:github_token, token)
    flash[:message] = 'You are now connected to Github'
    redirect_to dashboard_path
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      redirect_to welcome_path
    else
      flash[:error] = 'Sorry, User does not exist'
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
