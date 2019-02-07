class ConfirmationController < ApplicationController
  def create
    ConfirmationNotifierMailer.confirm(current_user).deliver_later
    redirect_to dashboard_path
  end

  def update
    user = User.find(params[:id])
    user.update(activated: true)
    session[:user_id] = user.id
    flash[:success] = "Thank you! Your account is now activated."
    redirect_to dashboard_path
  end
end
