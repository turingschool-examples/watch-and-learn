class Github::SessionsController < ApplicationController
	def create
		user_info = request.env['omniauth.auth']
		User.find_or_create_by(id: user_info["uid"])
		session[:github_id] = user_info["uid"]
		redirect_to dashboard_path
	end
end
