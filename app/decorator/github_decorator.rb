class GithubDecorator

  def initialize(user)
    @user = user
    create_github_service
  end

  def create_github_service
    @github_service = GithubService.new(@user)
  end

  def list_five_repos
    repos = @github_service.user_repos
    repos = repos[0..4].map do |repo|
      UserRepository.new({
        name: repo[:name],
        html_url: repo[:html_url]
        })
    end
  end
end
