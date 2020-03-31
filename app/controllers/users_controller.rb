class UsersController < ApplicationController
  def show
    if current_user.username
      @repos = SearchFacade.new().get_repos(current_user.username)[0..4]
      @followers = SearchFacade.new().get_followers(current_user.username)[0..4]
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
      @user = User.new
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
