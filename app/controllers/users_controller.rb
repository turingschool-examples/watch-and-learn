class UsersController < ApplicationController
  def show
    current_user.reload
    @bookmarks = current_user.bookmark_tutorials
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
      UserActivationMailer.activate(user).deliver_now
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def edit
    update
  end

  def update
    user = User.find(params[:id])
    user.update(activated: true)
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
