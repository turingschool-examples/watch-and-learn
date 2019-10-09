class UserFacade
  def repos
    GithubService.new.get_repos.map do |hash|
      Repo.new(hash)
    end.first(5)
  end
end
