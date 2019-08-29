class UsersController < ApplicationController
  def show
    @user = UserDashboardFacade.new(current_user)
    @tutorials = Tutorial.joins(videos: :user_videos).where("user_videos.user_id = #{current_user.id}").distinct
    @bookmarks = current_user.user_videos
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
    params.require(:user).permit(:email, :first_name, :last_name, :password, :handle)
  end

end
