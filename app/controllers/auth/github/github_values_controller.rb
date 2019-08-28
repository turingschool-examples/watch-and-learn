class Auth::Github::GithubValuesController < ApplicationController

  def create
    token = request.env["omniauth.auth"]["credentials"]["token"]
    uid = request.env["omniauth.auth"]["uid"]
    handle = request.env["omniauth.auth"]["info"]["nickname"]
    GithubValue.create(token: token, uid: uid, user_id: current_user.id, handle: handle)
    redirect_to dashboard_path
  end
end
