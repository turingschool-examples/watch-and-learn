require 'faraday'
require 'json'

class UsersController < ApplicationController
  def show
    @repos = JSON.parse(connection.body, symbolize_names: true)[0..4]
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

  def connection
    Faraday.get('https://api.github.com/users/davidttran/repos?sort="updated"')
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
