# frozen_string_literal: true

class ActivationController < ApplicationController
  def show
    user = User.find_by(activation_token: params[:token])
    user.update(activated: true)
    session[:user_id] = user.id
    redirect_to dashboard_path
  end
end
