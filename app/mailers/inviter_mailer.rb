class InviterMailer < ApplicationMailer
  def invite(contact)
    mail(to: contact, subject: 'Join our Turing Tutorials app!')
  end
end
