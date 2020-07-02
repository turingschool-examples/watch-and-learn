class Following
  attr_reader :login, :link
  def initialize(following_data)
    @login = following_data[:login]
    @link = following_data[:html_url]
  end
end
