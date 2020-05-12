class UserAuthController < ApplicationController
  def create
    response = request.env['omniauth.auth']
    current_user.update_auth(response)
    flash[:success] = 'Successfully logged in through GitHub.'
    redirect_to dashboard_path
  end
end
