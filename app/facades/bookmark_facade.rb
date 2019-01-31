class BookmarkFacade
  def initialize(user)
    @user = user
  end

  def tutorials
    Tutorial.joins(videos: :users).where(users: {id: @user.id}).includes(:videos)
  end
end
