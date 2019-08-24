class Follower
  attr_reader :login, :url, :in_system

  def initialize(attributes = {})
    @login = attributes[:login]
		@url = attributes[:html_url]
		@in_system = UserCredential.exists?(nickname: @login)
  end

	# def friendable?(login)
	# 	 !UserCredential.where("nickname = ?", login).empty?
	# end
end
