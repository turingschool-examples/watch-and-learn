class NewUserNotifierMailer < ApplicationMailer
  default from: 'no-reply@brownfield.com'

  def registration_email(user, email)
    # might be unecessary
    # @user = params[:user]
    @user = user
    # maybe change to just /dashboard
    @url = "http://localhost:3000/dashboard"
    mail(to: email, subject: 'Brownfield Account Confirmation')
  end
end
