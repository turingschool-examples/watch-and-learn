# frozen_string_literal: true

# Service PORO for github
class GitHubService
  def initialize(user_name, github_token)
    @user_name = user_name
    @github_token = github_token
  end

  def repos
    get_json('repos')
  end

  def followers
    get_json('followers')
  end

  def following
    get_json('following')
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.github.com/user/') do |f|
      f.params['access_token'] = @github_token
      f.adapter Faraday.default_adapter
    end
  end
end
