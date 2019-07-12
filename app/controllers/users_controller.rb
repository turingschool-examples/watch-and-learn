# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    if current_user
      render locals: {
        github_facade: GithubFacade.new(current_user),
        tutorials: Tutorial.tutorials_with_videos(current_user.id)
      }
    else
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      user_saved(user)
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    auth = request.env['omniauth.auth']
    current_user.update(github_token: auth[:credentials][:token], uid: auth[:uid])
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def user_saved(user)
    session[:user_id] = user.id
    UserNotifierMailer.inform(user, user.email).deliver_now
    flash[:message] = "Logged in as #{user.first_name} #{user.last_name}"
    flash[:notice] = 'This account has not yet been activated. Please check your email.'
  end
end
