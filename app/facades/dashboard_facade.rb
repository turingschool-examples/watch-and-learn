class DashboardFacade
  def initialize(user)
    @user = user
  end

  def repos(quantity)
    result = GithubService.new(@user).repos_by_user
    result.map do |raw_repo|
      Repository.new(raw_repo)
    end
  end
end
