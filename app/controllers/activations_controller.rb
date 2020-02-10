class ActivationsController < ApplicationController
  def update
    user = User.find(params[:id])
    merchant.toggle!(:active)
      if merchant.active?
        flash[:notice] = "Status: Active"
        redirect_to dashboard_path
      else
        flash[:notice] = "Your account has not yet been activated. Please try again."
        redirect_to dashboard_path
      end
  end
end
