class InvitesController < ApplicationController
  
  def new
  end
  
  def create
    presenter = InvitePresenter.new(current_user, params[:github_handle])
    
    if presenter.invitee_info[:email]
      InviterMailer.invite(presenter.invitee_info, presenter.inviter_info).deliver_now
      flash[:notice] = 'Successfully sent invite!'
    else
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end