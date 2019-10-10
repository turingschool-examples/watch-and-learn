class GithubController < ApplicationController

  def create
    @current_user = current_user
    token = auth_hash["credentials"]["token"]
    @current_user.update_attribute(:github_token, token)
    @current_user.save
    redirect_to '/dashboard'
  end

  private
  def auth_hash
    request.env["omniauth.auth"]
  end
end
