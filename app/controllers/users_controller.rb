class UsersController < ApplicationController
  def show
    @search_github = SearchGithubFacade.new(current_user.token) if current_user && current_user.token
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "This account has not been activated. Please check your email"
      flash[:header] = "Logged in as #{user.first_name}"
      redirect_to :controller => 'confirmation', :action => 'create'
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
