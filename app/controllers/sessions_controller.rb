# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    if request.env['omniauth.auth']
      user = User.from_omniauth(current_user.id, request.env['omniauth.auth'])
      flash[:notice] = 'Logged into Github'
      redirect_to dashboard_path
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
