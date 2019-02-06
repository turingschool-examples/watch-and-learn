class InviteController < ApplicationController
  def new
  end

  def create
    if invitation.save
      successful_invitation_actions
    else
      unsuccessful_invitation_actions
    end
  end

  private

  def facade
    github_handle = params[:invite][:github_handle]
    GithubInvitationFacade.new(current_user.github_token, github_handle)
  end

  def invitation
    @_invitation ||= facade.invitation
  end

  def successful_invitation_actions
    AccountInviteMailer.invite(invitation).deliver_now
    flash[:success] = 'Successfully sent invite!'
    redirect_to dashboard_path
  end

  def unsuccessful_invitation_actions
    flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    redirect_to dashboard_path
  end
end
