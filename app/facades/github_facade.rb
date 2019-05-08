class GithubFacade

  def initialize(current_user)
    @current_user = current_user
  end

  def repos(quantity)
    all_repos = repo_data.map do |repo_data|
      Repo.new(repo_data)
    end
    
    all_repos.sample(quantity)
  end

  private

  def repo_data
    @_repo_data ||= service.get_repos
  end

  def service
    @_service ||= GithubService.new
  end
end
