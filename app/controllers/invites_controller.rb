class InvitesController < ApplicationController
  
  def new
  end
  
  def create
    user_info = GithubService.info_by_username(params[:github_handle])
    InviterMailer.invite(user_info[:email]).deliver_now
    flash[:notice] = 'Successfully sent invite!'
    redirect_to dashboard_path
  end
end