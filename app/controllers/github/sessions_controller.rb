class Github::SessionsController < ApplicationController
  def create
    omniauth_handshake = request.env['omniauth.auth']
    user = current_user
    token = omniauth_handshake.credentials.token
    user.update(token: token)
    redirect_to dashboard_path
  end
end
