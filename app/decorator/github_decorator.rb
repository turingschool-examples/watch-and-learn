class GithubDecorator

  def initialize
    create_github_service
  end

  def create_github_service
    @github_service = GithubService.new
  end

  def list_five_repos
    @github_service.user_repos(current_user)
  end
end
