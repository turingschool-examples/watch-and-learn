class UsersController < ApplicationController
  def show
    @repos = get_repos.first(5)
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

  def get_repos
    GithubService.new.get_repos.map do |hash|
      Repo.new(hash)
    end
  end
end
