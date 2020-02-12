class VerificationEmailNotifierMailer < ApplicationMailer
  def inform(user, data)
    @user = user
    binding.pry
    mail(to: @user.email, subject: 'Account Creation')
  end
end
