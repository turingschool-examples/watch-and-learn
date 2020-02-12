class UserData
  # def initialize(token)
  #   @token = token
  # end

  def initialize(current_user, github_status)
    @current_user = current_user
    github_status = github_status
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
