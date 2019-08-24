class GithubController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth']
    current_user.github_update(auth_hash)
  end
end
