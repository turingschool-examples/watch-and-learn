class GithubFacade

  def initialize(current_user)
    @user = current_user
    @key = @user.git_key
  end

  def repos(limit)
    limited = newest_repos.take(limit)
    limited.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  private

    def newest_repos
      sorted = repo_data.sort_by { |repo| repo["updated_at"] }
      limited = sorted.reverse!
    end

    def repo_data
      @_repo_data = service.get_repos
    end

    def service
      @_service ||= GithubService.new(@user)
    end

end
