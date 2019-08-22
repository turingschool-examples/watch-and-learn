class UsersController < ApplicationController
  def show
    render locals: {
    facade: UserFacade.new
    }
        #do I need to append .gethub_repos?
  end

  def new
    user = User.new
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

  private
  def user_params
    params.permit(:email, :first_name, :last_name, :password, :token)
  end

end
