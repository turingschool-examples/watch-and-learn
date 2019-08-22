class DashboardFacade
  def initialize(user)
    if user.token
      @service = GithubService.new(user)
      @auth = true
    else
      @auth = false
    end
  end

  def is_auth?; @auth end

  def repos
    if @auth
      @_repos ||= get_repos
    else
      []
    end
  end

  private
  attr_reader :service

  def get_repos
    service.fetch_repos.take(5).map do |raw_repo|
      Repo.new(raw_repo)
    end
  end
end
