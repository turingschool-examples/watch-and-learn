class ActivationController < ApplicationController
  def update
    if current_user
      current_user.update(activation?: true)
      flash[:success] = "Thank you! Your account is now activated."
      redirect_to dashboard_path
    else
      flash[:notice] = "This account has not yet been activated. Please check your email."
      redirect_to login_path
    end
  end
end
