class Following
  attr_reader :name, :url, :u_id
  def initialize(data)
    @name = data[:login]
    @url = data[:html_url]
    @u_id = data[:id]
  end

  def check_user_exists
    User.where(uid: u_id).any?
  end
end
