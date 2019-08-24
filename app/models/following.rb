class Following
  attr_reader :login, :html_url

  def initialize(attrs = {})
    @login = attrs[:login]
    @html_url = attrs[:html_url]
  end
end
