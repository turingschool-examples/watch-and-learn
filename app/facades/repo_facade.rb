# frozen_string_literal: true

class RepoFacade

  def repos
    github_service.repo_info.take(5).map do |repo|
      Repo.new(repo)
    end
  end

  private

  def github_service
    GithubService.new
  end

end
