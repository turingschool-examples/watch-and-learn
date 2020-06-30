class GithubService
  def repos
    repos = conn.get("/user/repos")
    JSON.parse(repos.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.github.com") do |req|
      req.headers["Authorization"] = "token #{ENV["GITHUB_TOKEN"]}"
    end
  end
end
