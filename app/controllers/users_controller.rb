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
    current_user.update(github_id: new_github_id,
                        github_token: new_github_token)
    redirect_to '/dashboard'
  end

  private

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password)
    end

    def new_github_id
      if request.env['omniauth.auth']
        request.env['omniauth.auth']['uid']
      end
    end

    def new_github_token
      if request.env['omniauth.auth']
        request.env['omniauth.auth']['credentials']['token']
      end
    end
end
