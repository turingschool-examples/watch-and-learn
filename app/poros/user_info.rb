class UserInfo
  def github_repos
    service = GithubService.new
    @github_repos ||= service.repos_by_user.map do |repo|
      Repo.new(repo)
    end
  end
end
