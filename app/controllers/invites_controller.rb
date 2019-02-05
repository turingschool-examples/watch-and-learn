class InvitesController < ApplicationController
  
  def new
  end
  
  def create
    email = GithubService.email_by_username(params[:github_handle])
    redirect_to dashboard_path
  end
end