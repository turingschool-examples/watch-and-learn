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
      Person.new(follower_data)
    end
  end

  def following
    followings_data = github_service.following
    followings_data.map do |following_data|
      Person.new(following_data)
    end
  end

  def all_users
    @all_users ||= User.all_github_usernames
  end

  def bookmarked_videos
    @bookmarked_videos ||= @user.videos.order_by_tutorial_id
  end

  def bookmarked_tutorial_title(id)
    Tutorial.find(id)
  end

  def previous_tutorial_id(video)
    current_index = bookmarked_videos.find_index(video)
    if (current_index - 1).negative?
      nil
    else
      bookmarked_videos[current_index - 1].tutorial_id
    end
  end

  private

  attr_reader :user

  def github_service
    GithubService.new(user)
  end
end
