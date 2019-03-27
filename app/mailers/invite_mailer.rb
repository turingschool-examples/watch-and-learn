class InviteMailer < ApplicationMailer

  def invite(user, github_user)
    @user = user
    @github_user = github_user
    mail(to: @github_user.email, subject: "#{@user.first_name} wants to invite you to Brownfield of Dreams.")
  end


end
