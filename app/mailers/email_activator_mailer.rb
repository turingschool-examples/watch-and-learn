class EmailActivatorMailer < ApplicationMailer

  def activation_email
    # binding.pry
    @user = params[:user]
    # @url = 'http://example.com/activate'
    mail(to: @user.email, subject: "Activate Your Account")
  end
end
