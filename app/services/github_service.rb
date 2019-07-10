# frozen_string_literal: true

class GithubService
  def initialize(user)
    @user = user
  end

  def repos
    fetch('/user/repos').sample(5)
  end

  def followers
    fetch('/user/followers')
  end

  def following
    fetch('/user/following')
  end

  def email_search(username)
    auth_fetch("/users/#{username}")
  end

  private

  def fetch(path)
    response = conn.get(path)
    JSON.parse(response.body, symbolize_names: true)
  end

  def auth_fetch(path)
    response = conn.get(path) do |req|
      req.params['client_id'] = ENV['GITHUB_KEY']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{user.github_token}" if user.github_token
      faraday.adapter Faraday.default_adapter
    end
  end

  private

  attr_reader :user
end
