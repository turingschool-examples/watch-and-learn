class UserDashboardFacade < SimpleDelegator
  def initialize(user)
    super(user)
    @github_facade = GithubFacade.new(user.github_token)
    @bookmark_facade = BookmarkFacade.new(user)
    @user = user
  end

  def my_bookmarked_tutorials
    @bookmark_facade.tutorials
  end

  def friends_with?(friend_id)
    Friendship.where(user_id: @user.id, friend_id: friend_id).exists?
  end

  def has_github?
    @user.github_token ? true : false
  end

  def repos
    @github_facade.repos
  end

  def followers
    @github_facade.followers
  end

  def followings
    @github_facade.followings
  end
end
