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
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.first_name} #{user.last_name}"
      flash[:notice] = 'This account has not yet been activated. Please check your email.'
      ActivationMailer.activation(current_user).deliver_now
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
