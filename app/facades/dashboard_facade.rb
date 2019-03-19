class DashboardFacade
  def initialize(user)
    @user = user
    @github = GithubService.new
  end

  def repositories
    @repositories ||= @github.user_repositories(@user)[0..4].map do |repository_info|
      Repository.new(repository_info)
    end
  end
end
