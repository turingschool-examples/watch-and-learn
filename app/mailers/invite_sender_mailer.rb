class InviteSenderMailer < ApplicationMailer
  def invite(user, github_user)
    @user = user
    @github_user = github_user
    mail(to: @github_user.email, subject: "#{@user.first_name} has invited you to Turing Tutotials!!!1!")
  end
end
