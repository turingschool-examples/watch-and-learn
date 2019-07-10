# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      if user.email_confirmed
        session[:user_id] = user.id
        redirect_to dashboard_path
      else
        flash[:error] = "Please confirm your email address to activate your account."
      end
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
