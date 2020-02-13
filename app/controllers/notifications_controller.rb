class NotificationsController < ApplicationController
  def create
    ActivationNotifierMailer.inform(current_user, params[:email]).deliver_now
    flash[:notice] = 'An email has been sent to your account.'
    redirect_to dashboard_path
  end
end
