class User::GithubCredentialsController < ApplicationController
  def create
    token = current_user.tokens.find_or_create_by(uid: auth[:uid])

    token.username = auth[:extra][:raw_info][:login]
    token.provider = auth[:provider]
    token.token = auth[:credentials][:token]
    token.save

    redirect_to dashboard_path
  end

  protected

  def auth
    request.env['omniauth.auth']
  end
end
