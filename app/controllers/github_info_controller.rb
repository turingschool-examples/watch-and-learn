class GithubInfoController < ApplicationController
  def create
    current_user.update(token: token, connected?: true, handle: handle, github_name: name)
    redirect_to dashboard_path
  end

  private

  def token
    request.env['omniauth.auth']['credentials']['token']
  end

  def handle
    request.env['omniauth.auth']['info']['nickname']
  end

  def name
    request.env['omniauth.auth']['info']['name']
  end
end
