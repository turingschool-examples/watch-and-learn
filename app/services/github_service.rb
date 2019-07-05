# frozen_string_literal: true

class GithubService

  def initialize(user)
    @user = user
  end

  def repo_info
    get_json('/user/repos', sort: 'updated')
  end

  def follower_info
    get_json('/user/followers')
  end

  def following_info
    get_json('/user/following')
  end

  private
  def get_json(url, params = nil)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.basic_auth(@user.id, @user.github_token)
      f.adapter Faraday.default_adapter
    end
  end
end
