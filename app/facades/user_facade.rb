# frozen_string_literal: true

class UserFacade
  attr_reader :service

  def initialize(current_user)
    @service = GithubApiService.new
    @current_user = current_user
  end

  def all_repo_data
    @service.get_repo_data(@current_user).map do |repo_hash|
      Repo.new(repo_hash)
    end
  end

  def limit_repo_five
    all_repo_data.first(5)
  end

  def repo_data
    limit_repo_five
  end

  def follower_data
    @service.get_follower_data(@current_user).map do |follower_hash|
      GithubUser.new(follower_hash)
    end
  end

  def following_data
    @service.get_following_data(@current_user).map do |following_hash|
      GithubUser.new(following_hash)
    end
  end

  def find_github_user_data(github_login)
    user_hash = @service.search_user_login(@current_user, github_login)
    GithubUser.new(user_hash)
  end

  def user_tutorials
    @current_user.videos.order('position ASC').group_by(&:tutorial_id)
  end
end
