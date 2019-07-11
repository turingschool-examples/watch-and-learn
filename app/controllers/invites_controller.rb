class InvitesController < ApplicationController
  def new; end

  def create
    invite = Invite.new(params[:invitee_github_handle], current_user)
    if invite.send
      flash[:message] = "Successfully sent invite!"
    else
      flash[:message] = "The Github user you selected doesn\'t have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end
