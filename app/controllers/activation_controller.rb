class ActivationController < ApplicationController
  def update
    if current_user && current_user.id == params[:id].to_i
      activate(current_user)
    else
      redirect_to(login_path)
    end
  end

  def show
  end

  private

  def activate(user)
    user.update(status: 'active')
    reload_current_user
    redirect_to(activation_success_path)
  end
end
