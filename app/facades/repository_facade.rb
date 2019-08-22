class RepositoryFacade
	def initialize(token)
		@token = token
	end

  def repositories
    @_repositories ||= repository_data[0..4].map {|data| Repository.new(data)}
  end

  private

  def service
    @_service ||= GithubService.new(@token)
  end

  def repository_data
    @_repository_data ||= service.repository_data
  end
end
