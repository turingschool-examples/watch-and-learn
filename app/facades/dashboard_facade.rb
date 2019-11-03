# frozen_string_literal: true

class DashboardFacade
  attr_reader :token

  def initialize(current_user)
    @current_user = current_user
    @token = current_user.github_token
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

  def friends
    @friends ||= @current_user.friendships.map { |data| Friend.new(data) }
  end

  def bookmarks
    # @bookmarks ||= @current_user.bookmarks.group_by(&:tutorial_title).map do |tutorail, videos|
    #   Bookmark.new(tutorail, videos)
    # end
    @bookmarks ||= @current_user.bookmarks
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
