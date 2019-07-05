# frozen_string_literal: true

class GithubFacade

  def initialize(user)
    @token = user[:github_token]
  end

  def repos
    github_service.repo_info.take(5).map do |repo|
      Repo.new(repo)
    end
  end

  def followers
    github_service.follower_info.map do |follower|
      GithubUser.new(follower)
    end
  end

  def followings
    github_service.following_info.map do |following|
      GithubUser.new(following)
    end
  end

  private

  def github_service
    GithubService.new(@user)
  end

end
