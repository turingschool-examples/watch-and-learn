class VerificationEmailNotifierMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: "#{user.first_name} You have created an account.")
  end
end
