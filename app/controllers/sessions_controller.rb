class SessionsController < ApplicationController
  def new
    @user = User.new
    flash[:message] = 'You must login to bookmark videos.' if request.env['QUERY_STRING'] == "bookmark"
  end

  def create

    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id

      redirect_to dashboard_path
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
