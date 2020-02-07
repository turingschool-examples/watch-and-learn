class RepoSearch
  def initialize(token)
    @token = token
  end

  def display_repos
      service = GithubService.new
      service.get_json_repos(@token).map do |data|
        Repo.new(data)
      end
  end
end
