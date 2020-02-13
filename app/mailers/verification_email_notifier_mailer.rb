# frozen_string_literal: true

class VerificationEmailNotifierMailer < ApplicationMailer
  def inform(user, user_contact)
    @user = user
    mail(to: user_contact, subject: "#{user.first_name} Account Created!")
  end
end
