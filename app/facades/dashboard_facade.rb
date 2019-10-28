# frozen_string_literal: true

class DashboardFacade

  # def initialize
  #   @repositories = get_repositories
  # end

  def repositories
    repositories_data[0..4].map { |data| Repository.new(data) }
  end

  def followers
    @followers ||= follower_data[0..4].map { |data| Follower.new(data) }
  end

  private 

  def service
    @service ||= GithubService.new
  end

  def repositories_data
    @repositories_data ||= service.repository_data
  end

  def follower_data
    @followers_data ||= service.follower_data
  end

end
