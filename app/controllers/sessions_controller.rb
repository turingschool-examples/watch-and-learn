class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    unless auth_hash
      normal_user_login
    else
      github_user(auth_hash)
    end
  end

  def normal_user_login
    user = User.find_by(email: params[:session][:email])
    check_user(user)
  end

  def check_user(user)
    if user && user.authenticate(params[:session][:password])
      valid_user(user)
    else
      invalid_user
    end
  end

  def valid_user(user)
    session[:user_id] = user.id
    redirect_to dashboard_path
  end

  def invalid_user
    flash[:error] = "Looks like your email or password is invalid"
    render :new
  end

  def github_user(auth_hash)
    user = User.find_or_create_from_auth_hash(auth_hash, current_user)
    session[:user_id] = user.id
    redirect_to dashboard_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
