class GithubUser

  attr_reader :name,
              :address,
              :id

  def initialize(attributes)
    @name = attributes[:login]
    @address = attributes[:html_url]
    @id = attributes[:id]
  end

  def registered_user?
    User.where(uid: id).any?
  end
end
