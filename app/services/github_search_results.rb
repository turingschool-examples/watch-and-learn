# frozen_string_literal: true

class GithubSearchResults

  def initialize(current_user)
    @current_user = current_user
  end

  def repos
    response = conn.get('/user/repos', access_token: @current_user.github_token)
    repo_data = JSON.parse(response.body, symbolize_names: true)
  end

  def followers
    response = conn.get('/user/followers', access_token: @current_user.github_token)
    follower_data = JSON.parse(response.body, symbolize_names: true)
  end

  def followed_accounts
    response = conn.get('/user/following', access_token: @current_user.github_token)
    followed_accounts_data = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
