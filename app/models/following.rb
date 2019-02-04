class Following
  attr_reader :login, :html_url, :uid
  def initialize(attributes)
    @login = attributes[:login]
    @html_url = attributes[:html_url]
    @uid = User.find_by(uid: attributes[:id])
  end

  def self.find_all_following(token)
    data = GithubService.find_following(token)
    data.map do |raw_following|
      Following.new(raw_following)
    end
  end

  def has_account?
    if @uid
      true
    else
      false
    end
  end
end
