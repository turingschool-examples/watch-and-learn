class ActivationController < ApplicationController

  def edit
  end

  def update
    if current_user && current_user.id == params[:id].to_i
      successful_user_activation_actions(current_user)
    else
      redirect_to(login_path)
    end
  end

  def show
  end

  private

  def successful_user_activation_actions(user)
    flash[:success] = "Thank you! Your account is now activated."
    user.update(email_activation_status: 'active')
    reload_current_user
    redirect_to(activation_success_path)
  end
end
