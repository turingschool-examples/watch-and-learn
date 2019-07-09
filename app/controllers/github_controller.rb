class GithubController < ApplicationController
	def create
		token	= auth_hash['credentials']['token']
		current_user.token = Token.find_or_create_by(github_token: token)
		current_user.update(html_url: auth_hash["info"]["urls"]["GitHub"])
		redirect_to dashboard_path
	end

	private 

	def auth_hash
		request.env['omniauth.auth']
	end
end
