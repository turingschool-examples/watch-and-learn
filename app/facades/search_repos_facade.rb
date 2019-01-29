class SearchReposFacade

  def initialize(api_key)
    @api_key = api_key
  end

  def repos
    all_repos = search_results.map do |repo_data|
      Repo.new(repo_data)
    end
    all_repos[0..4]
  end

  private
  def search_results
    @_search_results ||= service.all_repos
  end

  def service
    GithubService.new(@api_key)
  end
end
