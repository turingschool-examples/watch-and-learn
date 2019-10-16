# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def registration_email(user, url)
    @user = user
    @url = url
    mail(to: user.email, subject: 'Activate your Account')
  end

  def invite_guest(current_user, guest, url)
    @user = current_user
    @guest = guest
    @url = url

    mail(to: guest.email, subject: "#{current_user.first_name} has invited you to Brownfield")
  end
end
