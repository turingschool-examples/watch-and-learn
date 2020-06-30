class GithubResults
  def repos(token)
    json = GithubService.new.repos(token)
    @repos = json.map { |repo_data| Repo.new(repo_data) }
  end
end
