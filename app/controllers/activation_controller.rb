# frozen_string_literal: true

class ActivationController < ApplicationController
  def create
    ActivateMailer.register(current_user).deliver_now
    redirect_to dashboard_path
  end
end
