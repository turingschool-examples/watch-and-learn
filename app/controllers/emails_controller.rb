class EmailsController < ApplicationController
  def new
    recipient = User.find(session[:user_id])
    EmailConfirmationMailer.inform(recipient).deliver_now

    flash[:success] = "Logged in as #{recipient.first_name}"
    flash[:notice] = 'This account has not yet been activated. Please check your email.'
    redirect_to "/dashboard"
  end

  def update
    user = current_user.update_attribute(:email_status, true)
    flash[:success] = "Thank you! Your account is now activated."
    redirect_to "/activated"
  end
end
