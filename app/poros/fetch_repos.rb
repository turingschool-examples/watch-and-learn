class FetchRepos
  def get_repos
    service = GithubService.new
    service.fetch
  end

  def limit_five
    raw_repo_data = get_repos
    raw_repo_data[0..4].map do |data|
      Repo.new(data[:name], data[:html_url])
    end
  end

end
