class Github::SessionsController < ApplicationController
	def create
		user_info = request.env['omniauth.auth']
		current_user.add_credential("github", user_info)
		redirect_to dashboard_path
	end
end
