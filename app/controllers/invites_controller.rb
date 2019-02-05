class InvitesController < ApplicationController
  
  def new
  end
  
  def create
    user_info = GithubService.info_by_username(params[:github_handle])
    if user_info[:email]
      InviterMailer.invite(user_info, current_user).deliver_now
      flash[:notice] = 'Successfully sent invite!'
    else
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end