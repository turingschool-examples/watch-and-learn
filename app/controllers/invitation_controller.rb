class InvitationController < ApplicationController

  def new

  end

  def create
    user = GithubService.new(current_user).get_user(params[:handle])
    github_user = GithubUser.new(user)

    if github_user.registered_user?
      flash[:error] = "Error: That user is already a member of Brownfield of Dreams"
    elsif github_user.email
      InviteMailer.invite(current_user, github_user).deliver_now
      flash[:notice] = "Successfully sent invite!"
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end

    redirect_to dashboard_path
  end
end
