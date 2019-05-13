module RegisteredHelper
  def registered?
    User.find_by(github_login: self.login).present?
  end
end
