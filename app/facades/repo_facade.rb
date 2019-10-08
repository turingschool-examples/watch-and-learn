class RepoFacade

  def create_repos
    get_repo_data.map do |repo|
      Repo.new(repo)
    end[0..4]
  end

  def get_repo_data
    GithubSearchResults.new.repos
  end
end
