require './app/models/github/api.rb'

class UsersController < ApplicationController
  def show
    response = GithubApi.new(current_user)
    @repos = response.parse_info('repos?sort="created"')
    @followers = response.parse_info('followers')
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
