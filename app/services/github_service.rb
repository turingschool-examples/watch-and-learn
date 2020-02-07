class GithubService
  def get_json(url)
    response = Faraday.get("https://api.github.com#{url}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def repo_url(token)
    url = "/user/repos?access_token=#{token}"
    get_json(url)
  end

  def following_url(token)
    url = "/user/following?access_token=#{token}"
    get_json(url)
  end
end
