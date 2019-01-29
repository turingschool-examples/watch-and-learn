class GithubService
  def initialize(user)
    @user = user
  end

  def find_repos
    get_json('/user/repos')
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true).take(5)
  end

  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = ENV["GITHUB_TOKEN"]
      faraday.adapter Faraday.default_adapter
    end
  end

end
