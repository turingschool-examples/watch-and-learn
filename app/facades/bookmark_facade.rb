class BookmarkFacade
  def initialize(user)
    @user = user
  end

  def tutorials
    @user.tutorials.includes(:videos)
  end
end
