class Github::SessionsController < ApplicationController
  def create
    omniauth_handshake = request.env['omniauth.auth']
    user = current_user
    token = omniauth_handshake.credentials.token
    name = omniauth_handshake.extra.raw_info.login
    user.update(token: token, github_name: name)
    redirect_to dashboard_path
  end
end
