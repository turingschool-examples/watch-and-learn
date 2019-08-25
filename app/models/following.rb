class Following
	attr_reader :login, :url, :user_id

	def initialize(data = {})
		@login = data[:login]
		@url = data[:html_url]
		@user_id = get_user_id
	end

	def get_user_id
		cred = UserCredential.where(nickname: @login)
		cred.empty? ? nil : cred[0]["user_id"]
	end
end
