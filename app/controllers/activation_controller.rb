class ActivationController < ApplicationController
  def activate
    @user = User.find(params[:id])
    @user.update_attribute(:status, 1)
    #flash[:notice] = "Thank you! Your account is now activated."
    #redirect_to dashboard_path
  end
end
