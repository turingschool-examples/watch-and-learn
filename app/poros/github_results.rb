class GithubResults
  def repos
    json = GithubService.new.repos
    @repos = json.map { |repo_data| Repo.new(repo_data) }
  end
end
