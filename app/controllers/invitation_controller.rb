class InvitationController < ApplicationController
  def new

  end

  def create
    user = current_user
    @facade = GitHubFacade.new(user)
    friend = @facade.github_handle(params[:github_handle])
    if friend[:email].nil?
      flash[:notice] = "The Github user you've selected doesn't have an email address associated with their account."
      redirect_to dashboard_path
    else
      InvitationMailer.invite(friend, user).deliver_now
      flash[:notice] = 'Successfully sent invite!'
      redirect_to dashboard_path
    end
  end
end
