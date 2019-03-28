# frozen_string_literal: true

class InvitationMailer < ApplicationMailer
  def invite(sender_username, sender_email, recipient_username, recipient_email)
    @sender_username = sender_username
    @recipient_username = recipient_username
    subject = 'Invitation to join Brownfield of Dreams'
    mail(to: recipient_email, from: sender_email, subject: subject)
  end
end
