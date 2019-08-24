class GithubService
  def repos_by_updated_at(token)
    get_json("https://api.github.com/user/repos?sort=updated_at&access_token=#{token}")
  end

  def followers(token)
    get_json("https://api.github.com/user/followers?access_token=#{token}")
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
