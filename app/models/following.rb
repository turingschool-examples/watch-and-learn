class Following
  attr_reader :login, :html_url, :user
  def initialize(attributes)
    @login = attributes[:login]
    @html_url = attributes[:html_url]
    @user = User.find_by(github_id: attributes[:uid])
  end

end
