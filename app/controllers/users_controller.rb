# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    render locals: {
      facade: UserGithubFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      send_mail_and_redirect(user)
    else
      @user = User.new
      flash[:error] = 'Email already exists'
      render :new
    end
  end

  private

  def send_mail_and_redirect(user)
    user.set_activation_token
    ActivationMailer.activate(user).deliver_now!
    session[:user_id] = user.id
    redirect_to dashboard_path
    flash[:success] = "Logged in as #{user.first_name}"
    # rubocop:disable Metrics/LineLength
    flash[:error] = 'This account has not yet been activated. Please check your email.'
    # rubocop:enable Metrics/LineLength
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
