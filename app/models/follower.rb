class Follower
  attr_reader :login, :html_url, :uid
  def initialize(attributes)
    @login = attributes[:login]
    @html_url = attributes[:html_url]
    @uid = User.find_by(uid: attributes[:id])
  end

  def self.find_all_followers(token)
    data = GithubService.find_followers(token)
    data.map do |raw_follower|
      Follower.new(raw_follower)
    end
  end

  def has_account?
    if @uid
      true
    else
      false
    end 
  end

end
