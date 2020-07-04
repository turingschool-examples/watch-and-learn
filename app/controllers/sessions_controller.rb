class SessionsController < ApplicationController
  def new
    @user = User.new
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
    session[:github_token] = nil
    redirect_to root_path
  end

  def update 
    binding.pry
    code = params[:code]
    github_token = request.env['omniauth.auth'][:credentials][:token]
    current_user.update(github_token: github_token)
    if current_user.save
      session[:github_token] = github_token
    end
    redirect_to dashboard_path
  end
end
