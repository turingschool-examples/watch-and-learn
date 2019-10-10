class FollowersFacade
  def create_followers(current_user)
    get_follower_data(current_user).map do |follower|
      Follower.new(follower)
    end
  end

  def get_follower_data(current_user)
    GithubSearchResults.new(current_user).followers

  end
end
