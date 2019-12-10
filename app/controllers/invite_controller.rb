class InviteController < ApplicationController
  def new
  end

  def create
    invite_facade = InviteFacade.new(current_user, params[:github_handle])

    if invite_facade.invitee_email
      InviteMailer.invite(invite_facade).deliver_now
      flash[:notice] = 'Successfully sent invite!'
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end
