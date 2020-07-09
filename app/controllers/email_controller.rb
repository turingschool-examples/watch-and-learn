class EmailController < ApplicationController

  def index
  end

  def create
    @email = EmailGenerator.new
    friend_email = params[:friends_email]
    email_info = {
      user: current_user,
      friend: params[:friends_name],
      message: @email.message
    }
    EmailSenderMailer.inform(email_info, friend_email).deliver_now
    flash[:notice] = 'Thank you, your email has been sent'
    redirect_to email_url
  end
end
