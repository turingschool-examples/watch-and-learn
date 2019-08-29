class EmailActivatorMailer < ApplicationMailer

  def activation_email
    @user = params[:user]
    mail(to: @user.email, subject: "Activate Your Account")
  end
end
