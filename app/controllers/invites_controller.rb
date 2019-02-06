class InvitesController < ApplicationController
  
  def new
  end
  
  def create
    invitee_info = GithubService.new(current_user).info_by_username(params[:github_handle])
    inviter_info = GithubService.new(current_user).user_info
    if invitee_info[:email]
      InviterMailer.invite(invitee_info, inviter_info).deliver_now
      flash[:notice] = 'Successfully sent invite!'
    else
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end