class UsersController < ApplicationController
  def show
    return unless current_user.token

    github_decorator = GithubDecorator.new(current_user)
    @users_repos = github_decorator.list_five_repos
    @user_followers = github_decorator.followers
    @user_following = github_decorator.following
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:notice1] = "Logged in as #{user.first_name} #{user.last_name}"
      flash[:notice2] = "This account has not yet been activated. Please check your email."
      # send_email(user)
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      redirect_to new_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def send_email(user)
    recipient = params[:email]
    email_info =  {
                    user: user,
                    message: "Visit here to activate your account."
                  }
    RegistrationMailer.inform(email_info, recipient).deliver_now
  end
end
