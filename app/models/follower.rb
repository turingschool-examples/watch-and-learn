class Follower
  attr_reader :handle,
              :url,
              :uid

  def initialize(follower)
    @handle = follower[:login]
    @url = follower[:html_url]
    @uid = follower[:id].to_s
  end

  def not_a_friend?(current_user_id)
    friend_id = self.get_user_id
    Friendship.joins(:user)
              .find_by(user_id: current_user_id, friend_user_id: friend_id)
              .nil?
  end

  def get_user_id
    User.find_by(github_uid: self.uid)
        .id
  end
end
