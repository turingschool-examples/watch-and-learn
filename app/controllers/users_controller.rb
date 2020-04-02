class UsersController < ApplicationController

  def show
    render locals: {
      search_results: GithubSearch.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      activation_process(user)
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

  def activation_process(user)
    ActivationMailer.activate_user(user).deliver_now
    render_flash(user)
  end

  def render_flash(user)
    user_name = user.first_name + " " + user.last_name
    flash[:success] = "Logged in as #{user_name}"
    flash[:email] = "This account has not yet been activated. Please check your email."
  end

end
