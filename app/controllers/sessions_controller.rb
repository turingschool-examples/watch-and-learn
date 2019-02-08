class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    successful_session if login_success?
    unsuccessful_session unless login_success?
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def login_success?
    @user && @user.authenticate(params[:session][:password])
  end

  def successful_session
    session[:user_id] = @user.id
    redirect_to dashboard_path
  end

  def unsuccessful_session
    flash[:error] = "Looks like your email or password is invalid"
    render :new
  end
end
