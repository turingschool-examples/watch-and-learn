class InviteController < ApplicationController
  def new; end

  def create
    gh_handle = params[:github_handle]
    email = invitee_email(gh_handle)
    if email
      send_email(gh_handle, email)
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = "The Github user you selected doesn't have an email
                      address associated with their account."
    end

    redirect_to dashboard_path
  end

  def invitee_email(gh_handle)
    user_data = UserData.new(current_user)
    user_data.get_email(gh_handle)
  end

  def send_email(gh_handle, email)
    app_invite = AppInviterMailer.invite(current_user, gh_handle, email)
    app_invite.deliver_now
  end
end
