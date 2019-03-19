class GithubService

  def initialize(user)
    @user = user
  end

  def user_repositories
    @user_repositories ||=  get_user_repositories
  end

  def user_followers
    @user_followers ||= get_user_followers
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{@user.github_token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_user_repositories
    JSON.parse(conn.get("/user/repos").body, symbolize_names: true)
  end

  def get_user_followers
    JSON.parse(conn.get("/user/followers").body, symbolize_names: true)
  end
end
