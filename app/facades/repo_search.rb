class RepoSearch
  def initialize(token)
    @token = token
  end

  def display_repos
    find_repos.take(5)
  end

  def find_repos
      service = GithubService.new
      service.get_json_repos(@token).map do |data|
        Repo.new(data)
      end
  end
end
