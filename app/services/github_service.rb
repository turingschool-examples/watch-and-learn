class GithubService
  def initialize(user)
    @user = user
  end

  def find_repos
    get_json('/user/repos')
  end

  def find_followers
    get_json('/user/followers')
  end

  def find_following
    get_json('/user/following')
  end


  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true).take(5)
  end

  def conn
    # binding.pry
    token = @user.github_token
    Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.params["access_token"] = token
      faraday.adapter Faraday.default_adapter
    end
  end

end
