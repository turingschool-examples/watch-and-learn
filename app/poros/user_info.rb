class UserInfo
  attr_reader :user

  def initialize(user)
    @user = user
    @token = user.github_token
  end

  def github_repos
    service = GithubService.new(@token)
    @github_repos ||= service.repos_by_user.map do |repo|
      Repo.new(repo)
    end
  end
end
