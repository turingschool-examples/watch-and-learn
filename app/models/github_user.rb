class GithubUser
  attr_reader :username,
              :github_url

  def initialize(data)
    @username = data[:login]
    @github_url = data[:html_url]
  end

  def linked_github?
    if User.find_by(github_name: @username)
      true
    else
      false
    end
  end
end
