class InviteMailer < ApplicationMailer

  def invite(user, github_user_email)
    @user = user
    mail(to: github_user_email, subject: "#{user.name} wants to invite you to Brownfield of Dreams.")
  end


end
