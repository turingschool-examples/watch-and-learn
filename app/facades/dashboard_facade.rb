class DashboardFacade
  def initialize(user)
    @service = GithubService.new(user)
  end

  def repos
    @_repos ||= get_repos
  end

  private
  attr_reader :service

  def get_repos
    service.fetch_repos.take(5).map do |raw_repo|
      Repo.new(raw_repo)
    end
  end
end
