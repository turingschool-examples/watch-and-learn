class GithubService
  def repository_data
    get_json("/user/repos")
  end

  def follower_data
    get_json("/user/followers")
  end

  private

  def conn
    @_conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = ENV['GITHUB_API_KEY']
      faraday.headers["Accept"] = "application/vnd.github.v3+json"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
