class ActivationsController < ApplicationController
  def update
    user = User.find(params[:id])
    user.toggle!(:active)
    if user.active?
      flash[:notice] = 'Status: Active'
    else
      flash[:notice] = 'Your account has not yet been activated. Please try again.'
    end
      redirect_to dashboard_path
  end
end
