class ActivateController < ApplicationController

  def update
    User.find(params[:id])
    user.update(activated: true)
    user.save
    flash[:notice] = "Thanks for activating your account!"
    redirect_to dashboard_path
  end
end
