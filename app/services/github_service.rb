# frozen_string_literal: true

class GithubService
  def repository_data
    get_json("/user/repos")
  end

  def follower_data
    get_json("/user/followers")
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = ENV['CLIENT_ID']
      faraday.adapter(Faraday.default_adapter)
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
