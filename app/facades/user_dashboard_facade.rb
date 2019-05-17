class UserDashboardFacade
attr_reader :user

  def initialize(user)
    @user = user
  end

  def inactive_user
    "partials/#{partials[user.email_confirmed]}"
  end

  def partials
    {
      "inactive" => "inactive_dashboard",
      "active"   => "active_dashboard"
    }
end

  def repositories(limit_index = 4)
    #can be refactored to
    #take a parameter which determines
    #how many repos to map
    repository_data[0..limit_index].map do |repository_data|
      Repository.new(repository_data)
    end
  end

  def followers
    follower_data.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def following
    following_data.map do |following_data|
      Follower.new(following_data)
    end
  end

  def friends
    @user.friended_users
  end

  private

    def repository_data
      @_repository_data ||= service.repository_info
    end

    def follower_data
      @_follower_info ||= service.follower_info
    end

    def following_data
      @_following_data ||= service.following_info
    end

    def service
      @_service ||= GithubService.new(@user.github_token)
    end
end
