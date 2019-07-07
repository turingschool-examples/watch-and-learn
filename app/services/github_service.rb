class GithubService
  def initialize(token)
    @conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token " + token
      faraday.adapter Faraday.default_adapter
    end
  end

  def find_repositories
    get_url("/user/repos")
  end

  def find_followers
    get_url("/user/followers")
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
