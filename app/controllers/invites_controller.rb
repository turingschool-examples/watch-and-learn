class InvitesController < ApplicationController
  
  def new
  end
  
  def create
    user_info = GithubService.info_by_username(params[:github_handle])
    
    redirect_to dashboard_path
  end
end