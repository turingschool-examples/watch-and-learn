class Following
	attr_reader :login, :url, :in_system

	def initialize(data = {})
		@login = data[:login]
		@url = data[:html_url]
		@in_system = UserCredential.exists?(nickname: @login)
	end
end
