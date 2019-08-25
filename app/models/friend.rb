class Friend
	attr_reader :login, :url

	def initialize(data)
		@login, @url = set_data(data)
	end

	def set_data(data)
		friend = data.friend.user_credentials.find_by(website: "github")
		[friend.nickname, friend.url]
	end
end
