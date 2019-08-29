class Following
  attr_reader :login, :html_url, :id, :token

  def initialize(attrs = {})
    @login = attrs[:login]
    @html_url = attrs[:html_url]
    @id = attrs[:id]
    @token = attrs[:token]
  end

  def github_user?
    token != nil
  end
end
