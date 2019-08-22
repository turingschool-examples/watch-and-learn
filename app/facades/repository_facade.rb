class RepositoryFacade
  def repositories
    @_repositories ||= repository_data[0..4].map {|data| Repository.new(data)}
  end

  private

  def service
    @_service ||= GithubService.new
  end

  def repository_data
    @_repository_data ||= service.repository_data
  end
end
