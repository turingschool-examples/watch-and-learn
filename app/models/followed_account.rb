class FollowedAccount
  attr_reader :name, :url, :uid

  def initialize(followed_account)
    @name = followed_account[:login]
    @url = followed_account[:html_url]
    @uid = followed_account[:id]
  end
end
