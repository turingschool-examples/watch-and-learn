class DashboardFacade
  def initialize(user)
    @user = user
  end

  def repos(quantity)
    result = GithubService.new(@user).repos_by_user
    repositories = []
    quantity.times do
      repositories << Repository.new(result.shift)
    end
    repositories
  end

end
