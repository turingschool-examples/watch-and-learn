class GithubService

  def repos
    get_json("/user/repos")
  end

  def followers
    get_json('/user/followers')
  end

  def following
    get_json('/user/following')
  end

  private
  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    @_conn ||= Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = 'token ' + ENV['GITHUB_API_KEY']
      f.adapter Faraday.default_adapter
    end
  end
end
