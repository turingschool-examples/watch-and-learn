class UsersController < ApplicationController
  def show
    render locals: {
      user_facade: UserFacade.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      activation_email(user)
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      redirect_to register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def activation_email(user)
    ActivationMailer.activate(user).deliver_now
    flash[:notice] = 'This account has not yet been activated.
                      Please check your email.'
  end
end
