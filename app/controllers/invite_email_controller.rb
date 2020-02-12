class InviteEmailController < ApplicationController

  def new
    #empty
  end

  def create
    data = GithubService.user_email(params[:github_handle], current_user.token)
    if data[:email] != nil
      EmailNotifierMailer.inform(current_user, data).deliver_now
      flash[:notice] = "Successfully sent invite!"
      redirect_to '/dashboard'
    else
      flash[:error] = 'Oops, something went wrong (probably due to email not being public).'
      redirect_to '/invite'
    end
  end
end
