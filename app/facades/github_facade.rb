# frozen_string_literal: true

class GithubFacade

  def repos
    github_service.repo_info.take(5).map do |repo|
      Repo.new(repo)
    end
  end

  def followers
    github_service.follower_info.take(5).map do |follower|
      Follower.new(follower)
    end
  end

  private

  def github_service
    GithubService.new
  end

end
