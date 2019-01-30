class Github::SessionsController < ApplicationController
  def create
    access_token = request.env["omniauth.auth"]["credentials"]["token"]
    current_user.update(github_token: access_token)
    current_user.save
    redirect_to dashboard_path
  end
end