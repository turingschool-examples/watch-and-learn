class InviterMailer < ApplicationMailer
  def invite(invitee_info, inviter_info)
    @name = invitee_info[:name]
    @inviter_name = inviter_info[:name]
    mail(to: invitee_info[:email], subject: 'Join our Turing Tutorials app!')
  end
end
