class UsersController < ApplicationController

  def show
    @user = User.find_by(params[:user_id])
    binding.pry
    if @user.token == nil
      []
    else
      conn = Faraday.new("https://api.github.com") do |req|
        req.headers["authorization"] = @user.token
      end

      response = conn.get("/user/repos")
      parsed = JSON.parse(response.body, symbolize_names: true)
        @repos = parsed.map do |repo_data|
          Repo.new(repo_data)
        end.first(5)
    end
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
