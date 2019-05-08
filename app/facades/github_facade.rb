class GithubFacade

  def initialize(current_user)
    @user = current_user
    @key = @user.git_key
  end

  def repos(limit)
    limited = repo_data.take(limit)
    limited.map do |repo_data|
      Repo.new(repo_data)
    end
    # array of repo objects(5)
    # service = data.something
  end

  private

    def repo_data
      @_repo_data = service.get_repos
    end

    def service
      @_service ||= GithubService.new(@user)
    end

end
