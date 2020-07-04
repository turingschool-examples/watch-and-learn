class SearchResults

  def repos
    json = GithubService.new.list_repos
    @repos = json[0..4].map do |user_data|
     Repo.new(user_data)
    end
  end
end
