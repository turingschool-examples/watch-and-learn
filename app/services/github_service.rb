# frozen_string_literal: true

class GithubService
  def initialize(token)
    @token = token
  end

  def conn
    Faraday.new(
      url: 'https://api.github.com',
      params: { access_token: @token }
    )
  end

  def conn_new
    Faraday.new(
      url: 'https://api.github.com',
      params: { access_token: ENV['GITHUB_ACCESS_TOKEN'] }
    )
  end
end
