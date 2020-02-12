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

  def user_handle
    request.env["omniauth.auth"]["extra"]["raw_info"]["login"]
  end

  def user_hash
    {token: auth_hash["credentials"]["token"],
     github_handle: user_handle}
  end
end
