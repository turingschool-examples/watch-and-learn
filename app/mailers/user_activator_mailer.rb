class UserActivatorMailer < ApplicationMailer
  def activate(user)
    # binding.pry
    @user = user
    mail(to: user.email, subject: 'Activate your Turing Tutorial Account')
  end
end
