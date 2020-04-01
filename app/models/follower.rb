class Follower
  attr_reader :name, 
              :url

  def initialize(info)
    @name = info[:login]
    @url = info[:html_url]
  end
end