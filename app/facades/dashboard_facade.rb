# frozen_string_literal: true

class DashboardFacade
  def initialize(token)
    @token = token
  end

  def repositories
    repositories_data[0..4].map { |data| Repository.new(data) }
  end

  def followers
    @followers ||= follower_data[0..4].map { |data| Follower.new(data) }
  end

  def following
    @following ||= follow_data[0..4].map { |data| Following.new(data) }
  end

  private

  def service
    @service ||= GithubService.new(@token)
  end

  def repositories_data
    @repositories_data ||= service.repository_data
  end

  def follower_data
    @follower_data ||= service.follower_data
  end

  def follow_data
    @follow_data ||= service.follow_data
  end
end