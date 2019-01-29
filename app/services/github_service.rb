class GithubService
  def initialize(token)
    @token = token
  end

  def repositories
    response = conn.get("/user/repos")
    json_repos = JSON.parse(response.body, symbolize_names: true)

    json_repos.map do |json_repo|
      Repository.new(json_repo)
    end
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |fd|
      fd.headers["Authorization"] = "token #{@token}"
      fd.adapter Faraday.default_adapter
    end
  end
end
