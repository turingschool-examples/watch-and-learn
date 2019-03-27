class GithubUser

  attr_reader :name,
              :address,
              :id,
              :email,
              :full_name

  def initialize(attributes)
    @name = attributes[:login]
    @address = attributes[:html_url]
    @id = attributes[:id]
    @email = attributes[:email]
    @full_name = attributes[:name]
  end

  def registered_user?
    User.where(uid: id).any?
  end

  def not_already_friend?(user)
    friend = User.where(uid: id)
    Friendship.where(user: user, friend: friend).none?
  end
end
