class InvitationsController < ApplicationController

  def new
  end

  def create

    github_handle = params[:github_handle]



    if InvitationNotifierMailer.invite(current_user, github_handle).deliver_now
  
      flash[:notice] = "Successfully sent invite!"

    else
      flash[:notice] = "There is no email associated with the github account you have selected."
    end

    redirect_to dashboard_path
  end

end
