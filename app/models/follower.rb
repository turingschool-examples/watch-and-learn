class Follower
  attr_reader :name, :url, :u_id, :user_exists

  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
    @u_id = data[:id].to_s
    @user_exists = check_user_exists
  end

  def check_user_exists
    User.where(uid: u_id).any?
  end
end
