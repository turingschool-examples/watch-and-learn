class AccountInviteMailer < ActionMailer::Base
  def invite(invitee_name, email, user)
    @user = user
    @invitee_name = invitee_name
    mail(to: email, subject: "#{user.first_name} invites you to the Turing Tutorials App.")
  end
end
