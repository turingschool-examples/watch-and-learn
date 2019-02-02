class GithubUser
  attr_reader :login, :html_url, :email
  def initialize(attributes)
    @login = attributes[:login]
    @html_url = attributes[:html_url]
    @email = attributes[:email]
  end
end
