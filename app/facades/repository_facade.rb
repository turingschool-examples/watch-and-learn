class RepositoryFacade
  attr_reader :repositories

  def initialize
    @repositories = get_repositories
  end

  def get_repositories
    repository_data[0..4].map {|data| Repository.new(data)}
  end

  private

  def service
    @_service ||= GithubService.new
  end

  def repository_data
    @_repository_data ||= service.repository_data
  end
end
