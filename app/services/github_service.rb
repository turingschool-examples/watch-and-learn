class GithubService

  def list_repos
    response = conn.get("/user/repos?access_token=#{ENV['GITHUB_ACCESS_TOKEN']}")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.github.com") do |req|
      req.adapter Faraday.default_adapter
      req.params[:key] = ENV['GITHUB_ACCESS_TOKEN']
    end
  end
end
