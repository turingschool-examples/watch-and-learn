class UsersController < ApplicationController
  def show
    @facade = DashboardFacade.new(current_user) if current_user.github_token
    @bookmarked_tutorials = Tutorial.bookmarked(current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user_saved?(user) 
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def user_saved?(user)
    if user.save
      session[:user_id] = user.id
    else
      flash[:error] = 'Username already exists'
    end
  end
end
