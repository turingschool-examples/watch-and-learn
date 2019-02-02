class ActivationController < ApplicationController
  def update
    user = User.find(params[:id])
    user.update(status: 'active')
    reload_current_user
    redirect_to(activation_success_path)
  end

  def show
  end
end
