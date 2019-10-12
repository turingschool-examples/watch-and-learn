class GithubService
  # frozen_string_literal: true

  def initialize(token)
    @token = token
  end

  def repos
    get_json('/user/repos')
  end

  def followers
    get_json('/user/followers')
  end

  def following
    get_json('/user/following')
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.params['access_token'] = @token
      faraday.adapter Faraday.default_adapter
    end
  end
end
