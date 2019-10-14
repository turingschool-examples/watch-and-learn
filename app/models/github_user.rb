class GithubUser
  attr_reader :github_id, :login, :html_url

  def initialize(github_user_hash)
    @github_id = github_user_hash[:id]
    @login = github_user_hash[:login]
    @html_url = github_user_hash[:html_url]
  end

  def is_user?
    User.find_by(github_id: @github_id)
  end

  # def already_friends?
  #   Friendship.find_by????
  # end
end
