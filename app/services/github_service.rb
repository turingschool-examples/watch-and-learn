class GithubService
  def get_json(url)
    response = Faraday.get("https://api.github.com#{url}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def user_url_path(path, token)
    url = "/user/#{path}?access_token=#{token}"
    get_json(url)
  end
end
