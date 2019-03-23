class ValidationMailer < ApplicationMailer
  def validate(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Brownfield!")
  end
end
