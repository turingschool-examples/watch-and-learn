class ActivationController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user.update(active: true)
    flash[:notice] = "Successfully actiaved your account!"
    redirect_to dashboard_path
  end
end
