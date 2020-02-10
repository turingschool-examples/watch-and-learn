class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    current_user.update(github_info)
    redirect_to '/dashboard'
  end

  private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password)
    end

    def github_info
      if request.env['omniauth.auth']
        {github_token: request.env['omniauth.auth']['credentials']['token'],
         github_id: request.env['omniauth.auth']['uid']}
      end
    end
end
