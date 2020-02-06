class Follower
  attr_reader :name, :url

  def initialize(info)
    @name = info[:name]
    @url = info[:url]
  end
end
