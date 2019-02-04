class Github::TokensController < ApplicationController
  def update
    current_user.update(uid: auth_info.uid, github_token: "token #{auth_info.credentials.token}")
    redirect_to dashboard_path
  end

  private

  def auth_info
    request.env['omniauth.auth']
  end
end
