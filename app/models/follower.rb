class Follower
  attr_reader :login, :html_url
  def initialize(attributes)
    @login = attributes[:login]
    @html_url = attributes[:html_url]
  end

  def self.find_all_followers(token)
    data = GithubService.find_followers(token)
    data.map do |raw_follower|
      Follower.new(raw_follower)
    end
  end

end
