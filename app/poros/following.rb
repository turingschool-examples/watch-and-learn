class Following
  attr_reader :name, :link
  def initialize(data)
    @name = data[:login]
    @link = data[:html_url]
  end
end
