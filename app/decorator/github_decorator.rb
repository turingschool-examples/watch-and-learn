class GithubDecorator

  def initialize(user)
    @user = user
    create_github_service
  end

  def create_github_service
    @github_service = GithubService.new(@user)
  end

  def list_five_repos
    @github_service.user_repos
  end
end
