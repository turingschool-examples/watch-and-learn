class Follower
  attr_reader :login, :html_url, :user
  def initialize(attributes)
    @login = attributes[:login]
    @html_url = attributes[:html_url]
    @user = false
  end

  def has_account?
    not_nil_users = User.where.not(github_name: nil).pluck(:github_name)
    if not_nil_users.include?(self.login)
      @user = true
    end
    @user
  end
  
end
