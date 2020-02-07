class UsersController < ApplicationController
  def show
    if current_user.token
      render locals: {
        repo_result: RepoSearch.new(current_user.token)
      }
    end
    # @repos = Repo.find_repos(current_user) if current_user.token
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
