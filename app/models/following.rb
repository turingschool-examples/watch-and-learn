class Following
  attr_reader :name, :url

  def initialize(following_data)
    @name = following_data[:login]
    @url  = following_data[:html_url]
  end
end
