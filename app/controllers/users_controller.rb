class UsersController < ApplicationController
  def show
    return unless current_user.token
    search = GithubSearch.new
    @git_repos = search.repos(current_user)
    @git_followers = search.followers(current_user)

    @git_following = search.following(current_user)

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

  def update

    user_friend = User.find(params[:user_id])
    @user = User.find_by(id: current_user.id)
    current_user.friends << user_friend

    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
