class ConnectionController < ApplicationController

  def create
    GithubToken.create(token: request.env["omniauth.auth"].credentials.token, user: current_user)
    redirect_to dashboard_path
  end
end
