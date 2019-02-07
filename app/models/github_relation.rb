class GithubRelation
  attr_reader :url, :name, :uid

  def initialize(data)
    @url = data[:html_url]
    @name = data[:login]
    @uid = data[:id]
    @user = User.find_by(github_uid: uid)
  end

  def on_our_site?
    @user ? true : false
  end

  def id
    @user.id if @user
  end
end
