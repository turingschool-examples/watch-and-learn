class InvitationController < ApplicationController

  def new
    
  end

  def create
    github_service = GithubService.new(current_user)
    email = github_service.get_email(params[:handle])["email"]

    if InviteMailer.invite(current_user, params[:email]).deliver_now
      flash[:notice] = "Successfully sent invite!"
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end
