class Following
  attr_reader :name, :url

  def initialize(following)
    @name = following[:login]
    @url = following[:html_url]
  end
end
