class Github::SessionsController < ApplicationController
  def create
    access_token = request.env["omniauth.auth"]["credentials"]["token"]
    uid = request.env["omniauth.auth"]["uid"]

    user = current_user

    user.github_token = access_token
    user.uid = uid

    user.save

    redirect_to dashboard_path
  end
end
