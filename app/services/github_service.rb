class GithubService
  def repos(token)
    repos = conn(token).get("/user/repos")
    JSON.parse(repos.body, symbolize_names: true)
  end

  def conn(token)
    Faraday.new("https://api.github.com") do |req|
      req.headers["Authorization"] = "token #{token}"
    end
  end
end
