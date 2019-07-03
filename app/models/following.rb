class Following
  attr_reader :name, :link
  def initialize(following_info)
    @name = following_info[:login]
    @link = following_info[:html_url]
  end
end
