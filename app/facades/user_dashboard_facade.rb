# frozen_string_literal: true

class UserDashboardFacade
  def initialize(user)
    @user = user
  end

  def repos
    repo_data = github_service.repos
    repo_data.map do |repo|
      Repo.new(repo)
    end
  end

  def followers
    followers_data = github_service.followers
    followers_data.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def following
    following_data = github_service.following
    following_data.map do |following_data|
      Following.new(following_data)
    end
  end

  def all_users
    @users ||= User.all_github_usernames
  end

  def bookmarked_videos
    # videos = UserVideo.where(user_id: @user.id)
    # binding.pry
    # user_videos = Video.where(id: videos).order(:tutorial_id)
    @user.videos.order_by_tutorial_id
  end

  private

  attr_reader :user

  def github_service
    GithubService.new(user)
  end
end
