class GithubService

  def initialize(token)
    @token = token
  end

  def list_repos
    get_url("repos")
  end

  def list_followers
    get_url("followers")
  end

  def list_followings
    get_url("following")
  end

  private

  def get_url(url)
    response = conn.get("/user/#{url}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.github.com") do |req|
      req.adapter Faraday.default_adapter
      req.headers["Authorization"] = "token #{@token}"
    end
  end
end
