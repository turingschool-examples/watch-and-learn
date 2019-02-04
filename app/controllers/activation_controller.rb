class ActivationController < ApplicationController
  def update
    if current_user && current_user.id == params[:id].to_i
      activate(current_user)
      redirect_to(activation_success_path)
      flash[:success] = "Thank you! Your account is now activated."
    else
      redirect_to(login_path)
    end
  end

  def show
  end

  private

  def activate(user)
    user.update(email_activation_status: 'active')
    reload_current_user
  end
end
