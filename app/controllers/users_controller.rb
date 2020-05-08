class UsersController < ApplicationController
  def show
    @list = current_user.repos unless current_user.token == '0'
    @followers = current_user.followers unless current_user.token == '0'
    @following = current_user.following unless current_user.token == '0'
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
