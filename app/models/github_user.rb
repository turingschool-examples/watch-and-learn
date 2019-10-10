class GithubUser
  attr_reader :login, :html_url

  def initialize(github_user_hash)
    @login = github_user_hash[:login]
    @html_url = github_user_hash[:html_url]
  end
end
