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
      session[:user_id] = @user.id
      flash[:success] = "Welcome, you are now registered and logged in."
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
