class GithubFacade
  attr_reader :token
  def initialize(token)
    @token = token
  end

  def repos
    github_data = GithubApiService.new(token)
    new_response = github_data.repos
    new_array = new_response.map do |repo|
      Repo.new(repo)
    end
    new_array
  end
end
