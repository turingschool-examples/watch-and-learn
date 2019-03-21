class Github::SessionsController < ApplicationController

  def create
    user = User.from_omniauth(request.env["omniauth.auth"], current_user)
    if user
      session[:user_id] = user.id
      redirect_to dashboard_path
    end
  end



end
