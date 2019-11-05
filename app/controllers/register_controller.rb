# frozen_string_literal: true

class RegisterController < ApplicationController
  def create
    user = User.find(params[:id])
    user.update_attributes(activate: true)
    flash[:notice] = "Thank you! Your account is now activated."
    redirect_to dashboard_path
  end
end
