class UsersController < ApplicationController
  def show
    render locals: {
      github: UserGithub.new(github_token)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      AccountActivatorMailer.activation(user).deliver_now
      flash[:notice] = "Please check your email for account activation."
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    user = User.find(params[:user_id])
    user.update(status: 1)
    flash[:notice] = 'Your account has been activated.'
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

end
