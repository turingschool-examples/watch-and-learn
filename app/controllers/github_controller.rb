class GithubController < ApplicationController
  # frozen_string_literal: true
  def create
    if current_user.gh_token.nil?
      current_user.update(gh_token: auth_hash[:credentials][:token])
      redirect_to dashboard_path
    else
      redirect_to root_path
    end
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
