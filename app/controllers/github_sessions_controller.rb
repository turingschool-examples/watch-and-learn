class GithubSessionsController < ApplicationController
  def create
    binding.pry
    client_id = ENV['GITHUB_API_KEY']
    client_secret = ENV['CLIENT_API_KEY']
    code = params[:code]
    response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{client_id}&client_secret=#{client_secret}&code=#{code}")
    response_hash = {}
    response.body.split("&").each do |pair|
      key, value = pair.split("=")
      response_hash[key] = value
    end

    token = response_hash["access_token"]

    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

    auth = JSON.parse(oauth_response.body)

    current_user.username = auth["login"]
    current_user.uid      = auth["id"]
    current_user.token    = token
    current_user.save
    session[:user_id] = current_user.id

    redirect_to dashboard_path
  end

end
