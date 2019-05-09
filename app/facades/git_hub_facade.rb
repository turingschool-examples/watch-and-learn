# frozen_string_literal: true

class GitHubFacade
  def initialize(user)
    @user = user
  end

  def repos
    repo_output = repo_data.map do |repo_data|
      Repo.new(repo_data)
    end
    repo_output.sample(5)
  end

  def followers
    follower_output = follower_data.map do |follower|
      Repo.new(follower)
    end
    follower_output.sample(5)
  end

  private

  def follower_data
    @_follower_data ||= service.get_followers
  end

  def repo_data
    @_repo_data ||= service.get_repos
  end

  def service
    @_service ||= GithubService.new(@user)
  end
end
