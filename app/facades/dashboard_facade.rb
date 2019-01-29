class DashboardFacade
  def initialize(user)
    @user = user
  end

  def repos(quantity)
    results = GithubService.new(@user)
  end
end
