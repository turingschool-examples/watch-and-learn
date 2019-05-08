class GithubService

  def initialize(user_id)
    @user = User.find(user_id)
  end

  def get_repos
    get_json("/user/repos")
  end

  private

    def get_json(url)
      response = conn.get(url)
      data = JSON.parse(response.body, symbolize_name: true)
    end

    def conn
      Faraday.new("https://api.github.com") do |f|
        f.headers["Authorization"] = @user.git_key
        f.adapter Faraday.default_adapter
      end
    end

end
