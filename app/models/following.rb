class Following
  attr_reader :name, :url
  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
  end
end
