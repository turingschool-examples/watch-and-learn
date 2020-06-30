class GithubService

  def conn
    conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = ENV["GITHUB_API_KEY"]
    end
  end

  def repos_body
    response = conn.get("/user/repos")
    repos_body = JSON.parse(response.body, symbolize_names: true)
  end

  
end