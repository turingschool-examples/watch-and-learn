  class ReposFacade

    def repos
      @repos ||= repo_data[0..4].map {|data| Repo.new(data)}
    end

    private

    def service
      @_service ||= GithubApi.new
    end

    def repo_data
      @_repo_data ||= service.repos
    end
  end
