# frozen_string_literal: true

class GithubSearchResults

  def initialize(current_user)
    @current_user = current_user
  end

  def repos
    response = conn.get('/user/repos', access_token: @current_user.github_token) # .json ???
    repo_data = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
