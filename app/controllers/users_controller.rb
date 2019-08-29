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
      user.set_confirmation_token
      user.save(validate: false)
      UserMailer.activate_account(user).deliver_now
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:token])
    if user
      user.validate_user
      user.save(validate: false)
      redirect_to confirm_email_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :handle)
  end
end
