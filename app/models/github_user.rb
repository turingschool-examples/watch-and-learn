class GithubUser
  attr_reader :name, :url

  def initialize(user_data)
    @name = user_data[:login]
    @url = user_data[:html_url]
  end
end
