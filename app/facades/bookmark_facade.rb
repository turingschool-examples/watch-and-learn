class BookmarkFacade
  def initialize(user)
    @user = user
  end

  def tutorials
    Tutorial.joins(videos: :users).where(users: {id: @user.id}).group(:id).includes(:videos)
  end
end
