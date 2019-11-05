# frozen_string_literal: true

class ActivateMailer < ApplicationMailer
  def register(current_user)
    @user = current_user
    mail(to: current_user.email, subject: "Activate Your Brownfield Account")
  end
end
