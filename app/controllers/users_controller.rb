class UsersController < ApplicationController
  def show
    render locals: {
                    facade: UserDashboardFacade.new(current_user)
                    }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserActivatorMailer.inform(@user).deliver_now
      session[:user_id] = @user.id
      flash[:success] = "Logged in as #{@user.first_name}."
      flash[:success] = "This account has not yet been activated. Please check your email."
      redirect_to dashboard_path
    else
      flash[:error] = 'Email already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
