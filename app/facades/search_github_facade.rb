class SearchGithubFacade

  def initialize(api_key)
    @api_key = api_key
  end

  def repos
    all_repos = search_repo_results.map do |repo_data|
      Repo.new(repo_data)
    end
    if all_repos.length >= 5
      all_repos[0..4]
    else
      all_repos
    end
  end

  def followers
    search_follower_results.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def following
    search_following_results.map do |following_data|
      Following.new(following_data)
    end
  end

  private
  def search_repo_results
    @_search_repo_results ||= service.all_repos
  end

  def search_follower_results
    @_search_follower_results ||= service.all_followers
  end

  def search_following_results
    @_search_following_results ||= service.all_following
  end

  def service
    GithubService.new(@api_key)
  end
end
