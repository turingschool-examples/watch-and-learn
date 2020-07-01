class UsersController < ApplicationController

  def show
    # require 'pry'; binding.pry
    # user = User.find_by(user_params[:id])
  
    conn = Faraday.new("https://api.github.com") do |req|
      req.headers["authorization"] = ENV["GH_API_KEY"] 
    end
    
    repos = conn.get("/user/repos")
    parsed = JSON.parse(repos.body, symbolize_names: true)
    @repos = parsed.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
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
