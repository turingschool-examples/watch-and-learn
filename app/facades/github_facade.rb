# frozen_string_literal: true

class GithubFacade

  def initialize(user)
    @current_user = user
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

  def find_user(github_user)
    User.where(login: github_user.uid)
  end

  def find_friend(github_user)
    @current_user.friends.where(login: github_user.uid)
  end

  private

  def github_service
    GithubService.new(@current_user)
  end

end
