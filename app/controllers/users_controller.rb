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
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def update
    token = request.env['omniauth.auth']['credentials']['token']
    nickname = request.env['omniauth.auth']["info"]["nickname"]
    current_user.update_attribute(:github_username, nickname)
    current_user.update_attribute(:github_token, token)
    flash[:message] = "You are now connected to Github"
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
