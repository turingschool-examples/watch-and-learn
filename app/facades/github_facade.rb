class GithubFacade

  def initialize(current_user)
    @current_user = current_user
  end

  def repos(quantity)
    all_repos = service.get_repos.map do |repo_data|
      Repo.new(repo_data)
    end

    all_repos.sample(quantity)
  end

  private

  def service
    @_service ||= GithubService.new
  end
end
