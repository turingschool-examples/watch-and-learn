# frozen_string_literal: true

class GithubFacade

  def initialize(user)
    @token = user[:github_token]
  end

  def repos
    if @token
      github_service.repo_info.take(5).map do |repo|
        Repo.new(repo)
      end
    else
      "No Repositories Found"
    end
  end

  def followers
    if @token
      github_service.follower_info.map do |follower|
        GithubUser.new(follower)
      end
    else
      "No Followers Found"
    end
  end

  def followings
    if @token
      github_service.following_info.map do |following|
        GithubUser.new(following)
      end
    else
      "You are not following anyone."
    end
  end

  private

  def github_service
    GithubService.new(@user)
  end

end
