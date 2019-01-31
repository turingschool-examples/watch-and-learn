class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    unless params[:code]
      user = User.find_by(email: params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to dashboard_path
      else
        flash[:error] = "Looks like your email or password is invalid"
        render :new
      end
    else
      user = User.find_or_create_from_auth_hash(auth_hash)
      session[:user_id] = user.id
      redirect_to dashboard_path
    end
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
