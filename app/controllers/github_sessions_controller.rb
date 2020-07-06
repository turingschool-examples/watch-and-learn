class GithubSessionsController < ApplicationController
  def create
    client_id = "3fa380206ec5d3804d3c"
    client_secret = "e7cc91804530dbb4d7de1a34545fd43aee3ba0c1"
    code = params[:code]
    response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")

    pairs = response.body.split("&")
      response_hash = {}
      pairs.each do |pair|
        key, value = pair.split("=")
        response_hash[key] = value
      end

    token = response_hash["access_token"]
    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")
    auth = JSON.parse(oauth_response.body)

    user          = User.find_or_create_by(uid: auth["id"])
    user.username = auth["login"]
    user.uid      = auth["id"]
    user.token    = token
    user.save

    session[:user_id] = user.id
    redirect_to dashboard_path
  end
end
