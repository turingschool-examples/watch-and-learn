class GithubService
  def user_repositories(user)
    @user_repositories ||=  get_user_repositories(user)
  end

  private

  def conn(user)
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["Authorization"] = "token #{user.github_token}"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_user_repositories(user)
    JSON.parse(conn(user).get("/user/repos").body, symbolize_names: true)
  end
end
