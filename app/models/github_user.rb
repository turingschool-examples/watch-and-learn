class GithubUser

  attr_reader :name,
              :address,
              :id,
              :email

  def initialize(attributes)
    @name = attributes[:login]
    @address = attributes[:html_url]
    @id = attributes[:id]
    @email = attributes[:email]
  end

  def registered_user?
    User.where(uid: id).any?
  end

  def not_already_friend?(user)
    friend = User.where(uid: id)
    Friendship.where(user: user, friend: friend).none?
  end
end
