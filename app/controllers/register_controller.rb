# frozen_string_literal: true

class RegisterController < ApplicationController
  def create
    user = User.find_by(activate: params[:code])
    if user.nil?
      flash[:error] = "User not found"
    else
      user.update_attributes(activate: "true")
      flash[:notice] = "Thank you! Your account is now activated."
      redirect_to dashboard_path
    end
  end
end
