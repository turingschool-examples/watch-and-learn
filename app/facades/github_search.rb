class GithubSearch

  def initialize(user)
    @github_token = user.github_token
    @id = user.id
  end

  def user_repos
    service.get_repos.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def user_followers
    service.get_followers.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def user_followings
    service.get_followings.map do |following_data|
      Following.new(following_data)
    end
  end

  def user_bookmarked_videos?
    return true if User.find(@id).user_videos.empty? == false
    return false if User.find(@id).user_videos.empty? == true
  end

  def user_bookmarked_videos
    UserVideo.get_bookmarked_video_info(@id)
  end

  def service
    GithubService.new(@github_token)
  end
end
