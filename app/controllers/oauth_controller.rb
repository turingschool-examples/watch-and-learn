class OauthController < ApplicationController
  def create
    access_token = retrieve_access_token
    current_user.github_key = "token #{access_token}"
    current_user.save!
    redirect_to dashboard_path
  end

  private

  def retrieve_access_token
    request.env["omniauth.auth"]["credentials"]["token"]
  end
end
