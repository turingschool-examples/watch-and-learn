class Auth::Github::UserTokenController < ApplicationController
  def create
    token = request.env["omniauth.auth"]["credentials"]["token"]
    uid = request.env["omniauth.auth"]["uid"]

    current_user.update(github_token: token, github_uid: uid)

    redirect_to dashboard_path
  end
end
