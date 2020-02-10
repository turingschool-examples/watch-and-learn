class ActivationNotifierMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user, subject: "#{user.name} Activate Your Account with Brownfield Project")
  end
end
