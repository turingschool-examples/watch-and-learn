class SignupController < ApplicationController
  def create
    token = auth_hash['credentials']['token']
    github_id = auth_hash["uid"]
    username = auth_hash["info"]["nickname"]
    current_user.update_attributes!(github_token: token, uid: github_id, username: username)
    current_user.save
    redirect_to dashboard_path
  end
  private

  def auth_hash
    @auth_hash ||= request.env['omniauth.auth']
  end

end
