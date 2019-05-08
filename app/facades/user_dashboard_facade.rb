class UserDashboardFacade

  def initialize(current_user)
    @current_user = current_user
  end


  def repositories(limit_index = 4)
    #can be refactored to
    #take a parameter which determines
    #how many repos to map
    repository_data[0..limit_index].map do |repository_data|
      Repository.new(repository_data)
    end
  end

  private

    def repository_data
      @_repository_data ||= service.github_info
    end

    def service
      @_service ||= GithubService.new(@current_user)
    end
end
