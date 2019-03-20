class GithubService
  def get_repos
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com/user/repos") do |faraday|
      faraday.headers["Authorization"] = "token c7a36670014fcac0b9668828c74c798380b92393"
      faraday.adapter Faraday.default_adapter
    end
  end
end
