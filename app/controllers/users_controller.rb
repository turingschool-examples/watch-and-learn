class UsersController < ApplicationController
  def show
    return unless current_user.github_token

    @results = GithubResults.new(current_user)
    @repos = @results.repos
    @followers = @results.followers
    @following = @results.following
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
