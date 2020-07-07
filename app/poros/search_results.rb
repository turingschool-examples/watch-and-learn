class SearchResults

  def repos(token)
    json = GithubService.new.list_repos(token)
    @repos = json[0..4].map do |user_data|
     Repo.new(user_data)
    end
  end

  def followers(token)
    json = GithubService.new.list_followers(token)
    @followers = json.map do |user_data|
      Follower.new(user_data)
    end
  end

  def followings(token)
    json = GithubService.new.list_followings(token)
    @followings = json.map do |user_data|
      Following.new(user_data)
    end
  end
end
