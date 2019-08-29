class EmailActivatorMailer < ApplicationMailer

  def activation_email
    binding.pry
    @user = params[:user]
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: "Active Your Account")
  end
end
