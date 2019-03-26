class EmailController < ApplicationController

  def update
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Thank you for registering! Your account is now active."
      redirect_to dashboard_path
    else
      flash[:error] = "Sorry, this user does not exist. Please try again or contact an administrator."
      redirect_to root_url
    end
  end

end
