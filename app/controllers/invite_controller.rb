class InviteController < ApplicationController
  def index
  end

  def create
    service = GithubService.new(current_user)
    response = service.get_email(params[:github_handle])
    if response[:email]
      github_user = GithubUser.new(response)
      InviteSenderMailer.invite(current_user, github_user).deliver_now
      flash[:success] = "Successfully sent invite!"
      redirect_to dashboard_path
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
      redirect_to dashboard_path
    end
  end
end
