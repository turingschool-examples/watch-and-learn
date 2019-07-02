class GithubFacade
  def initialize()

  end

  def repos(limit = nil)
    if limit
      repos = GithubService.new.repo_info.take(limit)
    else
      repos = GithubService.new.repo_info
    end
    repos.map do |repo|
      GithubRepo.new(repo)            
    end
  end
end
