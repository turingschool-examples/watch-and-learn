class GithubService

  def get_repos
    get_json("user/repos")
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com/") do |faraday|
      faraday.headers["Authorization"] = "token #{ENV["GITHUB_TOKEN"]}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
