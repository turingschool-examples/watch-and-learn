class ActivationNotifierMailer < ApplicationMailer
  def inform(user, _email)
    @user = user
    mail(to: user.email, subject: "#{user.first_name}
    Activate Your Account with Brownfield Project")
  end
end
