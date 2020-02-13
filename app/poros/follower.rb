class Follower
  attr_reader :name, :profile_path, :id
  def initialize(info, user)
    @name = info[:login]
    @profile_path = info[:html_url]
    if user == nil
      @id = nil
    else
      @id = user.id
    end
  end

  def with_us
    self.id != nil
  end

  def not_friends_already(current_user_id)
    check_friendship_table_count = Friendship.where(friend_id: self.id, user_id: current_user_id).count

    if check_friendship_table_count > 0
      return false 
    else
      return true
    end
  end
end
