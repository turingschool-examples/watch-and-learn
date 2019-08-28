class Following
  attr_reader :login, :url

  def initialize(attributes = {})
    @login = attributes[:login]
    @url = attributes[:html_url]
  end

  def user?
    User.joins(:tokens)
      .select("users.*")
      .where(tokens: {username: @login, provider: "github"})
      .take
  end
end
