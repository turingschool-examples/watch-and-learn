class FetchReposFacade
  def initialize(current_user)
    @current_user = current_user
  end

  def get_repos
    service = GithubService.new(@current_user)
    service.fetch
  end

  def limit_five
    raw_repo_data = get_repos
    raw_repo_data[0..4].map do |data|
      Repo.new(data[:name], data[:html_url])
    end
  end

end
