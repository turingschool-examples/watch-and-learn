class GithubUser
  attr_reader :username,
              :github_url

  def initialize(data)
    @username = data[:login]
    @github_url = data[:html_url]
  end
end
