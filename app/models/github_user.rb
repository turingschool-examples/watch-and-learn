class GithubUser
attr_reader :handle,
            :url,
            :uid
  def initialize(attributes)
    @handle = attributes[:login]
    @url = attributes[:html_url]
    @uid = attributes[:id]
  end

  def friendable?(user)
    this_user = User.find_by(uid: @uid)
    # If the github user exists, check if they haven't been friended by current_user
    this_user ? !(user.friend_users.include?(this_user)) : false
  end
end
