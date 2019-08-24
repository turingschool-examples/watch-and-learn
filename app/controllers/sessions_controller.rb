class SessionsController < ApplicationController
  def new
    @user ||= User.new
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

  def github_connect
    token = Token.find_or_create_by(user_id: current_user.id)

    token.provider = auth[:provider]
    token.token = auth[:credentials][:token]
    token.save

    session[:token_id] = token.id
    redirect_to dashboard_path
  end

  def destroy
    Token.destroy
    session.delete(:user_id)
    session.delete(:token_id)

    redirect_to root_path
  end

  protected

  def auth
    request.env['omniauth.auth']
  end
end
