class GithubService

  def initialize(user = nil)
    @user = user
  end

  def user_repositories
    @user_repositories ||=  get_json("/user/repos")
  end

  def user_followers
    @user_followers ||= get_json("/user/followers")
  end

  def user_following
    @user_following ||= get_json("/user/following")
  end

  def get_user(username)
    @email ||= get_json("/users/#{username}")
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{@user.github_token}" if @user
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
