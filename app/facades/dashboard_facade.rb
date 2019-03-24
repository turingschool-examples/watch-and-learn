class DashboardFacade
  def initialize(user)
    @user = user
    @github = GithubService.new(@user)
  end

  def repositories
    @repositories ||= @github.user_repositories[0..4].map do |repository_info|
      Repository.new(repository_info)
    end
  end

  def followers
    @followers ||= @github.user_followers.map do |github_user_info|
      GithubUser.new(github_user_info)
    end
  end

  def following
    @following ||= @github.user_following.map do |github_user_info|
      GithubUser.new(github_user_info)
    end
  end

  def bookmarked_videos
    @bookmarks ||= User.bookmarked_videos(@user)
  end

  def bookmark_segment
    bookmarked_videos.empty? ? 'empty_bookmarks' : 'bookmarks'
  end

  def render_github
    @user.github_token ? 'github' : 'github_connect'
  end

  def friends
    @friends ||= User.select("friend_users_friends.*")
                     .distinct
                     .joins(friends: {friend_user: :friends})
                     .where(id: @user)
  end

  def pending_requests
    @pending_requests = User.joins("JOIN friends a ON a.user_id = users.id")
                            .joins("LEFT OUTER JOIN friends b ON a.friend_user_id = b.user_id
                                    AND a.user_id = b.friend_user_id")
                            .where("a.friend_user_id = ?", @user.id)
                            .where("b.id IS NULL")
  end
end
