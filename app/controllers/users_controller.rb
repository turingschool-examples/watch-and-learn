class UsersController < ApplicationController

  def show
    conn = Faraday.new("https://api.github.com") do |req|
      faraday.headers["X-API-KEY"] = 
    end
    repos = conn.get(“/users/jhgould/repos”)
    # parsed = JSON.parse(repos.body, symbolize_name: true)
    require 'pry'; binding.pry
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
