# frozen_string_literal: true

class ActivationMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: 'Activate account by clicking activation link.')
  end
end
