class InvitesController < ApplicationController
  def new
  end

  def create
    sent = GithubService.send_invite(current_user, params["github_handle"])
    flash[:notice] = sent ? "Successfully sent invite!" : "The Github user you selected doesn't have an email address associated with their account."
    redirect_to dashboard_path
  end
end
