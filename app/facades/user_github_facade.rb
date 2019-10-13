class UserGithubFacade
  # frozen_string_literal: true

  def initialize(token)
    @token = token
  end

  def service
    GithubService.new(@token)
  end

  def repos
    service.repos.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
  end

  def followers
    service.followers.map do |repo_data|
      GithubUser.new(repo_data)
    end
  end

  def following
    service.following.map do |repo_data|
      GithubUser.new(repo_data)
    end
  end
end
