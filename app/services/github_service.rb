class GithubService

  def initialize(current_user)
    @current_user = current_user
  end

  def fetch_repos
    response = conn.get("user/repos")
    JSON.parse(response.body, symbolize_names: true)
  end

  def fetch_followers
    response = conn.get("user/followers")
    JSON.parse(response.body, symbolize_names: true)
  end

  def fetch_users
    response = conn.get("user/following")
    JSON.parse(response.body, symbolize_names: true)
  end

private

  def conn
    Faraday.new(url: "https://api.github.com", :ssl => {:verify => false}) do |f|
      f.adapter  Faraday.default_adapter
      f.params[:access_token] = @current_user.github_token
    end
  end
end
