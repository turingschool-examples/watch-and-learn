class UsersController < ApplicationController
  def show
    conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token 484cabdee3b4e5de4226ed80470600b274e435d9"
    end
    
    response = conn.get("/user/repos")
    body = JSON.parse(response.body, symbolize_names: true)
    repos = body.map do |repo_data|
      Repo.new(repo_data)
    end
    @repos_5 = repos[0..4]
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
