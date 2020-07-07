class UsersController < ApplicationController
  def show
    binding.pry
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

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
