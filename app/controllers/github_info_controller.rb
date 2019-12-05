class GithubInfoController < ApplicationController
  def create
    current_user.update(token: token, connected?: true)
    redirect_to dashboard_path
  end

  private
  def token
    request.env['omniauth.auth']['credentials']['token']
  end
end
