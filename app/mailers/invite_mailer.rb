class InviteMailer < ApplicationMailer
  def invite(email, name)
    @name = name
    mail(to: email, subject: 'Invitation to our App')
  end
end
