class UsersController < ApplicationController

  def show
    
    @user = User.find_by(params[:user_id])
    if @user.token == nil
      @repos = []
    else
      conn = Faraday.new("https://api.github.com") do |req|
        req.headers["authorization"] = @user.token
      end


      response_followers = conn.get("/user/followers")
      parsed_2 = JSON.parse(response_followers.body, symbolize_names: true)
        @followers = parsed_2.map do |follower_data|
          Follower.new(follower_data)
        end.first(5)
        

      
      repo_list = conn.get("/user/repos")
      parsed = JSON.parse(repo_list.body, symbolize_names: true)
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
