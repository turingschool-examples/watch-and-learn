class GithubService < ApplicationController
  def fetch
    response = conn.get("user/repos")
    JSON.parse(response.body, symbolize_names: true)
  end

private

  def conn
    Faraday.new(url: "https://api.github.com", :ssl => {:verify => false}) do |f|
      f.adapter  Faraday.default_adapter
      f.params[:access_token] = current_user.github_token
    end
  end
end
