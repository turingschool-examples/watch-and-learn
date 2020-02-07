class GithubSearch
  def initialize(token)
    @token = token
  end

  def display_repos
    find_repos.take(5)
  end

  def display_following
    find_following.take(5)
  end

  def find_following
    service = GithubService.new
    service.following_url(@token).map do |data|
      Following.new(data)
    end
  end

  def find_repos
      service = GithubService.new
      service.repo_url(@token).map do |data|
        Repo.new(data)
      end
  end
end
