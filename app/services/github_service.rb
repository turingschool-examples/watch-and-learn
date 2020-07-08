class GithubService

  def list_repos(token)
    get_url("repos")
    # response = conn.get("/user/repos?access_token=#{ENV['GITHUB_ACCESS_TOKEN']}")
    # json = JSON.parse(response.body, symbolize_names: true)
  end

  def list_followers(token)
    get_url("followers")
  end

  def list_followings(token)
    get_url("following")
  end

  private

  def get_url(url)
    response = conn.get("/user/#{url}?access_token=#{ENV['GITHUB_ACCESS_TOKEN']}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.github.com") do |req|
      req.adapter Faraday.default_adapter
      req.params[:key] = ENV['GITHUB_ACCESS_TOKEN']
    end
  end
end
