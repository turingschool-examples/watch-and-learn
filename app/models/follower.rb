class Follower
  attr_reader :name, :url, :uid

  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
    @uid = data[:id]
  end

end