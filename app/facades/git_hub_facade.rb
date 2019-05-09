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

  def following
    following_output = following_data.map do |following|
      Following.new(following)
    end
  end

  private

  def following_data
    @_following_data ||= service.get_following
  end

  def repo_data
    @_repo_data ||= service.get_repos
  end

  def service
    @_service ||= GithubService.new(@user)
  end
end
