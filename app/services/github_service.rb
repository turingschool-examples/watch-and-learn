class GithubService

  def initialize(user)
    @user = user
  end

  def get_users_followed
    get_json("user/following")
  end

  def get_repos
    get_json("user/repos")
  end

  def get_followers
    get_json("user/followers")
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.github.com/") do |faraday|
      faraday.params["type"] = "owner"
      faraday.headers["Authorization"] = "token #{@user.github_token.token}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
