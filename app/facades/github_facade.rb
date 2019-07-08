# frozen_string_literal: true

class GithubFacade

  def initialize(user)
    @user = user
  end

  def repos
    if github_service.repo_info.class == Hash
      []
    else
      github_service.repo_info.take(5).map do |repo|
        Repo.new(repo)
      end
    end
  end

  def followers
    if github_service.repo_info.class == Hash
      []
    else
      github_service.follower_info.map do |follower|
        binding.pry
        GithubUser.new(follower)
      end
    end
  end

  def followings
    if github_service.repo_info.class == Hash
      []
    else
      github_service.following_info.map do |following|
        GithubUser.new(following)
      end
    end
  end

  private

  def github_service
    GithubService.new(@user)
  end

end
