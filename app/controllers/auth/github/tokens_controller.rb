class Auth::Github::TokensController < ApplicationController

  def create
    token = request.env["omniauth.auth"]["credentials"]["token"]
    uid = request.env["omniauth.auth"]["uid"]
    Token.create(token: token, uid: uid, user_id: current_user.id)
    redirect_to dashboard_path
  end
end
