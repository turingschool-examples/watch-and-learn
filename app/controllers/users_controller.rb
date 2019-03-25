class UsersController < ApplicationController
  def show
    render locals: {
      github_facade: GithubFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      UserMailer.registration_email(@user).deliver_now
      session[:user_id] = @user.id
      flash[:success] = "You are logged in as #{@user.email}, but your account is not yet active. Please check your email and click the registration link to continue."
      redirect_to dashboard_path
    else
      flash[:error] = "Oops, something went wrong! Please try again, and make sure you've entered a unique email address."
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
