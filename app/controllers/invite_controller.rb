class InviteController < ApplicationController
  def new
  end

  def create
    if current_user && current_user.token
      create_and_send_invite_email
    end
    redirect_to dashboard_path
  end

  def create_and_send_invite_email
    @search_github = SearchGithubFacade.new(current_user.token)
    my_github = @search_github.find_my_name
    user_email = @search_github.find_email(params[:github_handle])
    deliver_if_valid(user_email, my_github)
  end

  def deliver_if_valid(user_email, my_github)
    if user_email
      FriendInviterMailer.create(user_email, params[:github_handle], my_github).deliver_now
      flash[:success] = "Successfully sent invite!"
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
  end
end
