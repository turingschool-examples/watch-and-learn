class UserData
  def initialize(current_user)
    @current_user = current_user
  end

  def display_repos
    get_json('repos').take(5)
  end

  def display_following
    get_json('following').take(5)
  end

  def display_followers
    get_json('followers').take(5)
  end

  def bookmarks
    UserVideo.bookmarks(@current_user.id)
  end

  def get_email(github_handle)
    service = GithubService.new
    token = @current_user.token
    data = service.get_json("/users/#{github_handle}?access_token=#{token}")
    data[:email]
  end

  def find_github_resource(data_type, data)
    resource = data_type.singularize.capitalize
    resource.constantize.new(data)
  end

  def get_json(data_type)
    service = GithubService.new

    service.user_url_path(data_type, @current_user.token).map do |data|
      find_github_resource(data_type, data)
    end
  end
end
