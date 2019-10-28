class DashboardFacade

  attr_reader :repositories

  def initialize
    @repositories = get_repositories
  end

  def service
    @_service ||= GithubService.new
  end

  def repositories_data
    @repositories_data = service.repository_data
  end

  def get_repositories
    repositories_data[0..4].map { |data| Repository.new }
  end
end