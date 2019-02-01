class UsersController < ApplicationController
  def show
    if current_user.github_token
      @github_facade = GithubFacade.new(current_user.github_token)
    end
    @bookmark_facade = BookmarkFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:instruction] = "This account has not yet been activated. Please check your email."
      flash[:message] = "Logged in as #{user.name}"
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
