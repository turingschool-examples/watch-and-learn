# frozen_string_literal: true

require_relative '../models/github/repo'
require_relative '../models/github/follower'
require_relative '../models/github/following'
# facade for github
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

  def following
    following_data.map do |following|
      Following.new(following)
    end
  end

  def github_handle(handle)
    conn = Faraday.new("https://api.github.com/users/#{handle}") do |f|
      f.params['access_token'] = @user.github_token
      f.adapter Faraday.default_adapter
    end
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def repos_data
    @repo_data ||= service.repos
    @repo_data.sample(5)
  end

  def followers_data
    @followers_data ||= service.followers
  end

  def following_data
    @following_data ||= service.following
  end

  def service
    @service ||= GitHubService.new(@user.username, @user.github_token)
  end
end
