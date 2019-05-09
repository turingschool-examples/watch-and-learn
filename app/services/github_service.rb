class GithubService

  def initialize(user)
    @user = user
  end

  def get_repos
    get_json("/user/repos")
  end

  def get_followers
    get_json("/user/followers")
  end

  private

    def get_json(url)
      response = conn.get(url)
      data = JSON.parse(response.body, symbolize_name: true)
    end

    def conn
      Faraday.new("https://api.github.com") do |f|
        # f.headers["Authorization"] = @user.git_key
        f.headers["Authorization"] = ENV["GITHUB_API_KEY"]
        f.adapter Faraday.default_adapter
      end
    end

end
