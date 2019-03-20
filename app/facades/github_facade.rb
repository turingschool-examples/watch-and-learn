class GithubFacade
  def repos
    response = service.get_repos
    response.map do |repo|
      Repo.new(repo)
    end
  end

  def service
    GithubService.new
  end
end
