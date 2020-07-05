class UsersController < ApplicationController
  def show
    return unless current_user.token
      @repos = SearchResults.new.repos(current_user.token)
      @followers = SearchResults.new.followers(current_user.token)
      @followed_users = SearchResults.new.following(current_user.token)
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
