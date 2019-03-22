class Github::SessionsController < ApplicationController
  before_action :require_login

  def create
    current_user.update!(github_extraction)
    redirect_to dashboard_path
  end

  private

  # Might want to change to model method?
  def github_extraction
    github_info = {}
    omniauth_info = request.env['omniauth.auth']
    github_info[:uid] = omniauth_info.uid
    github_info[:github_token] = omniauth_info.credentials.token
    github_info
  end
end
