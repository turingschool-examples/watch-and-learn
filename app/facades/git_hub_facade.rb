# frozen_string_literal: true

require_relative '../models/github/repo'
require_relative '../models/github/follower'
class GitHubFacade
  def initialize(user)
    @user = user
  end

  def repos
    repos_data.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def followers
    followers_data.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  private

  def repos_data
    @_repo_data ||= service.repos
    @_repo_data.sample(5)
  end

  def followers_data
    @_follower_data ||= service.followers
  end

  def service
    @_service ||= GitHubService.new(@user.username,@user.github_token)
  end
end
