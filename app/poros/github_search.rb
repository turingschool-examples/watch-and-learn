class GithubSearch

  def repos(user)
    service = GithubService.new
    json = service.repo_json(user)
    json.map do |data|
      Repos.new(data["name"], data["url"])
    end
  end

  def followers
  end

end
