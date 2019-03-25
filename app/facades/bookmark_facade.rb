class BookmarkFacade < SimpleDelegator
  def initialize(user)
    @user = user
  end

  def tutorials
    binding.pry
    Tutorial.joins(videos: :user_videos)
            .select("tutorials.*")
            .where(user_videos: {user_id: current_user.id})
            .distinct
  end

  def tutorial_user_videos(tutorial)
    #returns array of my user_videos
  end

end
