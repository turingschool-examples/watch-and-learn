class UsersController < ApplicationController
  def show
    render locals: {
      facade: UserFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      activation_email(user)
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.first_name}"
      flash[:notice] = 'This account has not yet been activated. Please check your email.'
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

  def activation_email(user)
    # hash the user id here
    UserActivatorMailer.activate(user).deliver_now
  end

end
