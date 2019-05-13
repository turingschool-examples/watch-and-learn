class InviteController < ApplicationController
  def index
  end

  def create
    service = GithubService.new(current_user)
    response = service.get_email(params[:github_handle])
    github_user = GithubUser.new(response)
    InviteSenderMailer.invite(current_user, github_user).deliver_now
    flash[:success] = "Successfully sent invite!"
    redirect_to dashboard_path
  end
end
