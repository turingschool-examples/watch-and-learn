class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
    if @user.token
      render locals: {
        search_results: GithubDataView.new(@user)
      }
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

  def update
    user = User.find(params[:id])
    user.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :token)
  end
end
