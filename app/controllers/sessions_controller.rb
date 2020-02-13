class SessionsController < ApplicationController
  def new
    if params[:hint]
      flash[:error] = "Must Login to Bookmark"
      @user ||= User.new
    else
      @user ||= User.new
    end
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = "Looks like your email or password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
