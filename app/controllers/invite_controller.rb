class InviteController < ApplicationController
  def new; end

  def create
    user = UserInfo.new(current_user)
    invitee = user.github_invitee(invitee_params[:handle])
    if invitee.email
      ActiveMailer.invite(current_user, invitee.email).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = "The GitHub user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end

  private
  def invitee_params
    params.require(:invite).permit(:handle)
  end
end
