# frozen_string_literal: true

class GitHubFacade
  def initialize(user)
    @user = user
  end

  def repos
    repo_data.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  private

  def repo_data
    @_repo_data ||= service.get_repos
  end

  def service
    @_service ||= GithubService.new(@user)
  end
end
