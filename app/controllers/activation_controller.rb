class ActivationController < ApplicationController
  def edit
    user = User.find_by(activation_token: params[:token])
    user.update(activated: true)
    user.update(activation_token: nil)
    flash[:success] = 'Status: Active'
  end
end