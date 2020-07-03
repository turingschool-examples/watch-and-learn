class GithubSearch

  def repos(user)
    service = GithubService.new
    json = service.repo_json(user)
    json.map do |data|
      Repo.new(data["name"], data["url"])
    end
  end

  def followers(user)
    service = GithubService.new
    json = service.follower_json(user)
    json.map do |data|
      Follower.new(data["login"], data["html_url"])
    end
  end

  def following(user)
    service = GithubService.new
    json = service.following_json(user)
    json.map do |data|
      Following.new(data["login"], data["html_url"])
    end
  end

end
