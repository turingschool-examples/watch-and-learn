# frozen_string_literal: true

# users controller
class UsersController < ApplicationController
  def show
    user = current_user
    user.github_token
    render locals: { facade: GitHubFacade.new(user) } if user.github_token
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      create_the_user(user)
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      @user = User.new
      render :new
    end
  end

  def create_the_user(user)
    flash[:notice] = "Logged in as #{user.first_name}"
    flash[:message] = 'This account has not yet been activated.'\
                      'Please check your email.'
    ActivationMailer.inform(user).deliver_now
  end

  def activation
    user = User.find_by(email: params[:email])
    user.update(status: 'active')
    redirect_to thankyou_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
