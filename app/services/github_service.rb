class GithubService
  def initialize(user)
    @user = user
  end

  def get_specific_user(github_username)
    get_json("users/#{github_username}")
  end

  def all_repos
    get_json("user/repos")
  end

  def all_followers
    get_json("user/followers")
  end

  def all_following
    get_json("user/following")
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.adapter Faraday.default_adapter
      f.params[:access_token] = @user.github_token
    end
  end

  def get_json(uri)
    response = conn.get(uri)
    JSON.parse(response.body, symbolize_names: true)
  end
end
