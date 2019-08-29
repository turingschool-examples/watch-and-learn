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
      session[:user_id] = user.id
      AccountActivatorMailer.activation(user).deliver_now
      flash[:notice] = "Please check your email for account activation."
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      redirect_to new_user_path
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
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
