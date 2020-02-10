class GithubController < ApplicationController

  def create
    user = User.find(current_user.id)
    user.update(user_hash)
    redirect_to dashboard_path
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end

  def user_hash
    {token: auth_hash["credentials"]["token"]}
  end
end
