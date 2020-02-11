class ActivationsController < ApplicationController
  def new
    # new
    require "pry"; binding.pry
    redirect_to '/activation'
  end

  def create
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
