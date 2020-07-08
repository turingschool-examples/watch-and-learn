class ActivationController < ApplicationController

  def update

    user = User.find(params[:id])
    user.update_attributes(email_confirmation: true)
    redirect_to dashboard_path
  end

end
