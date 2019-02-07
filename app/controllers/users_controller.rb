class UsersController < ApplicationController
  def show
    @user_facade = UserDashboardFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    successful_user_creation_actions     if @user.save
    unsuccessful_user_creation_actions     unless @user.save
  end

  private

  def successful_user_creation_actions
    AccountActivatorMailer.activation_request(@user).deliver_now
    session[:user_id] = @user.id
    flash[:instruction] = "This account has not yet been activated. Please check your email."
    flash[:message] = "Logged in as #{@user.name}"
    redirect_to dashboard_path
  end

  def unsuccessful_user_creation_actions
    render :new
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
