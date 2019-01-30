class Follower
  attr_reader :url, :name

  def initialize(data)
    @url = data[:html_url]
    @name = data[:login]
  end
end
