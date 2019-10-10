class FollowedAccount
  attr_reader :name, :url

  def initialize(followed_account)
    @name = followed_account[:login]
    @url = followed_account[:html_url]
  end
end
