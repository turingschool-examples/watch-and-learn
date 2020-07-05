class GithubSessionsController < ApplicationController
  def create
    code = params[:code]
    response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{ENV['GITHUB_CLIENT_ID']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}&code=#{code}")
    pairs = response.body.split("&")
    response_hash = {}
    pairs.each do |pair|
      key, value = pair.split("=")
      response_hash[key] = value
    end
    token = response_hash["access_token"]
    oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")
    parsed_response = JSON.parse(oauth_response.body, symbolize_names: true)

    current_user.update(github_login: parsed_response[:login], token: token)
    
    redirect_to dashboard_path
  end

end
