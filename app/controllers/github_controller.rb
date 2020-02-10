class GithubController < ApplicationController

  def create
    #
    # client_id     = ENV['RAILS_CLIENT_ID']
    # client_secret = ENV['RAILS_CLIENT_SECRET']
    # code          = params[:code]
    # response      = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")
    #
    # pairs = response.body.split("&")
    # response_hash = {}
    # pairs.each do |pair|
    #   key, value = pair.split("=")
    #   response_hash[key] = value
    # end
    #
    # github_token = response_hash["access_token"]
    user = User.find(current_user.id)
    user.update(user_hash)
    redirect_to dashboard_path
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end

  def user_hash
    # {uid: auth_hash["uid"], token: auth_hash["credentials"]["token"]}
    {token: auth_hash["credentials"]["token"]}
  end
end
