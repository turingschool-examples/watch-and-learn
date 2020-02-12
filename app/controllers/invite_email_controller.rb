class InviteEmailController < ApplicationController

  def new
    #require "pry"; binding.pry
  end

  def create
    email = GithubService.user_email(params[:github_handle], current_user.token)
    if email != nil
      EmailNotifierMailer.inform(current_user, email).deliver_now
      flash[:notice] = "Successfully told your friend that they've changed."
      redirect_to '/dashboard'
    else
      flash[:error] = 'Oops, something went wrong (probably email is not public).'
      redirect_to '/invite'
    end
  end
end
