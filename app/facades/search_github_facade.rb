class SearchGithubFacade

  def initialize(api_key)
    @api_key = api_key
  end

  def repos
    search_repo_results.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
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

  def find_email(github_handle)
    search_email_results(github_handle)[:email]
  end

  def find_my_name
    search_my_name[:login]
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

  def search_email_results(github_handle)
    @_search_email_results ||= service.find_email(github_handle)
  end

  def search_my_name
    @_search_my_name ||= service.find_my_name
  end

  def service
    GithubService.new(@api_key)
  end
end
