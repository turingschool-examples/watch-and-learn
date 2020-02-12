class InviteController < ApplicationController
  def new
  end

  def create
    gh_handle = params[:github_handle]
    token = current_user.token
    invitee_email = UserData.new(current_user, github_status).get_email(gh_handle)

    if invitee_email
      AppInviterMailer.invite(current_user, gh_handle, invitee_email).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end

    redirect_to dashboard_path
  end
end
