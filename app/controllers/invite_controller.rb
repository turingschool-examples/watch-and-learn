class InviteController < ApplicationController
  def new
  end

  def create
    github_handle = params[:invite][:github_handle]
    facade = GithubInvitationFacade.new(current_user.github_token, github_handle)
    AccountInviteMailer.invite(facade).deliver_now
    flash[:success] = 'Successfully sent invite!'
    redirect_to dashboard_path
  end
end
