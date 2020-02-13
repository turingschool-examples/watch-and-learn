class ActivationsController < ApplicationController
  def update
    user = User.find(params[:id])
    user.toggle!(:active)

    flash[:notice] = if user.active?
                       'Status: Active'
                     else
                       'Your account has not yet been activated. Please try
                       again.'
                     end

    redirect_to dashboard_path
  end
end
