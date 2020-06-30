class UsersController < ApplicationController

  def show
    # require 'pry'; binding.pry
    conn = Faraday.new("https://api.github.com") do |req|
      req.headers["authorization"] = "token 741479466d5ac1badff7d3ffc1776e1af9dc47f8"
    end
    repos = conn.get("/users/jhgould/repos")
    parsed = JSON.parse(repos.body, symbolize_names: true)
    @repo_list = parsed.map { |repos| repos[:name] }.first(5)
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
