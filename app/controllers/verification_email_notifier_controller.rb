# frozen_string_literal: true

class VerificationEmailNotifierController < ApplicationController
  def update
    user = User.find_by(confirm_token: params[:token])
    user.update(email_confirmed: true)
    redirect_to '/dashboard'
  end
end
