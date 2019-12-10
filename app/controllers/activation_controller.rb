class ActivationController < ApplicationController
  def update
    if current_user
      current_user.update(activated?: true)
      flash[:notice] = 'Thank you! Your account is now activated.'
      redirect_to dashboard_path
    else
      flash[:error] = 'Please register and activate your account.'
      redirect_to login_path
    end
  end
end
