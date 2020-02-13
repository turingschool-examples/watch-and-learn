class GithubController < ApplicationController
  def create
    current_user.update_token(auth_hash)
    redirect_to '/dashboard'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
