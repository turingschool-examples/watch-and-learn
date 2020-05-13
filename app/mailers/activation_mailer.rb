class ActivationMailer < ApplicationMailer
  def inform(info, email)
    @user = info
    mail(to: email, subject: "Please activate your account for Turing Tutorials.")
  end
end
