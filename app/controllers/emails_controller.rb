class EmailsController < ApplicationController
  def new
    user = User.find(session[:user_id])
    recipient = user.email
    message = "Visit here to activate your account."
    EmailConfirmationMailer.inform(recipient, message).deliver_now

    flash[:success] = "Logged in as #{user.first_name}"
    flash[:notice] = 'This account has not yet been activated. Please check your email.'
    redirect_to "/dashboard"
  end

  def create

  end

  def edit
    handle = params["Github handle:"]
    recipient = GithubService.new.fetch_user_by_gh_handle(handle, current_user.token)
    message = "Hello #{recipient[:name]}, you've been invited to join BFD. https://dashboard.heroku.com/apps/blooming-badlands-99255/register"
    if recipient[:email]
      EmailConfirmationMailer.inform(recipient[:email], message).deliver_now
      flash[:success] = "Successfully sent invite!"
      redirect_to "/dashboard"
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
      redirect_to "/dashboard"
    end
  end

  def update
    user = current_user.update_attribute(:email_status, true)
    flash[:success] = "Thank you! Your account is now activated."
    redirect_to "/activated"
  end
end
