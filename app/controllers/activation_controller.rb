class ActivationController < ApplicationController
  def activate
    if current_user
      if current_user.id == params[:id].to_i
        current_user.update_attribute(:status, 1)
      else
        four_oh_four
      end
    else
      flash[:notice] = "You must be logged in to activate your account. Please login and try again."
      redirect_to login_path
    end
  end
end
