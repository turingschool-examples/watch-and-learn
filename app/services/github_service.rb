class GithubService
  def initialize(user)
    @user = user
  end

  def repos_by_user
    conn = Faraday.new(url: "https://api.github.com") do |faraday|
           faraday.headers["Authentication"] = @user.token
           faraday.adapter Faraday.default_adapter
         end

    response = conn.get("user/repos")
    JSON.parse(response.body, symbolize_names: true)
  end

end
