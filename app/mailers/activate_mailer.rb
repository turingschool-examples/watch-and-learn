class ActivateMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: @user.email, subject: 'Visit here to activate your account.')
  end

  def invite(user, invitee_login, invitee_email)
    @user = user
    @invitee = [invitee_login, invitee_email]
    mail(to: invitee_email, subject: 'Join Turing Video Tutorials')
  end
end
