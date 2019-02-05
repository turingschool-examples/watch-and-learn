class InviterMailer < ApplicationMailer
  def invite(user_info, current_user)
    @name = user_info[:name]
    @inviter_name = current_user.first_name + ' ' + current_user.last_name
    mail(to: user_info[:email], subject: 'Join our Turing Tutorials app!')
  end
end
