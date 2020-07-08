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

  def update
    user = current_user.update_attribute(:email_status, true)
    flash[:success] = "Thank you! Your account is now activated."
    redirect_to "/activated"
  end
end
