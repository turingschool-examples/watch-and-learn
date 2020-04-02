class ActivationController < ApplicationController
  def create
    user = User.find(params[:user_id])
    user.update(github_token: auth_github_token, github_username: auth_github_username)
    flash[:activated] = "Status: Active"
    redirect_to '/dashboard'
  end

  private

  def auth_github_token
    request.env['omniauth.auth']['credentials']['token']
  end

  def auth_github_username
    request.env['omniauth.auth']['info']['nickname']
  end
end
