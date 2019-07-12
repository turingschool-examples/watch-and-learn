# frozen_string_literal: true

class ActivationController < ApplicationController
  def index
    User.find_by(email: params[:email]).update(active: true)
    flash[:notice] = 'Thank you! Your account is now activated.'
    redirect_to dashboard_path
  end
end
