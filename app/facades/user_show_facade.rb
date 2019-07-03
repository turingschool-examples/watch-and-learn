class UserShowFacade
  def repos
    repos_hash = GithubApiService.new.user_repos
    repos_hash.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
  end
end
