class GithubService
  def get_json_repos(token)
    response = Faraday.get("https://api.github.com/user/repos?access_token=#{token}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
