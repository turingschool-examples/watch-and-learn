class GithubService

  def initialize(github_token)
    @github_token = github_token
  end

  def get_repos
    get_json("/user/repos?page=1&per_page=5")
  end

  def get_followers
    get_json('/user/followers')
  end

  def get_followings
    get_json('/user/following')
  end


  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)

  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.headers["Authorization"] = "token #{@github_token}"
      f.adapter Faraday.default_adapter
    end
  end
end
