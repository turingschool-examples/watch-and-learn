class GithubService
  def github_repos(token)
    get_json(token).first(5).map do |repo_info|
      Repo.new(name: repo_info["name"], url: repo_info["html_url"])
    end
  end

  private

  def connection
    Faraday.new('https://api.github.com') do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(token)
    response = connection.get('user/repos', { access_token: token })
    JSON.parse(response.body)
  end
end
