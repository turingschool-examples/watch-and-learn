class UsersController < ApplicationController
  def show
    gs = GithubService.new(current_user) 
    gs.conn
    gs.get_json("/user/repos",1)
    @github_repos = gs.get_json("/#{current_user}/repos", 0 ,user)
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
