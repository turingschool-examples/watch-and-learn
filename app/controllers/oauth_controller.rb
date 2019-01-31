class OauthController < ApplicationController
  def create
    access_token = GithubService.retrieve_access_token(params[:code])
    # current_user.update(github_key: access_token)
    current_user.github_key = access_token
    current_user.password = "asdhgahg342gh"
    current_user.save!
    binding.pry
    redirect_to dashboard_path
  end
end
