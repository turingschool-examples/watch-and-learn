class UsersController < ApplicationController
  def show
    if current_user.token
      conn = Faraday.new(url: "https://api.github.com/") do |f|
            f.headers['Authorization'] = ("token #{current_user.token}")
            f.adapter Faraday.default_adapter
      end
      repo_response = conn.get("user/repos")
      repo_hash = JSON.parse(repo_response.body, symbolize_names: true)[0..4]
      @repos = repo_hash.map do |repo_data|
        Repo.new(repo_data)
      end
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
