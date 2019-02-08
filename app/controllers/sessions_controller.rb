class SessionsController < ApplicationController
  def new
    @user ||= User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    successful_session if @user && @user.authenticate(params[:session][:password])
    unsuccessful_session unless @user && @user.authenticate(params[:session][:password])
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def successful_session
    session[:user_id] = @user.id
    redirect_to dashboard_path
  end

  def unsuccessful_session
    flash[:error] = "Looks like your email or password is invalid"
    render :new
  end
end
