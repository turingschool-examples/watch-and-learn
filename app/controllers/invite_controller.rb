class InviteController < ApplicationController
  def show
  end

  def create
    if checks_for_email.email
      sends_email
    else
      returns_error_notice
    end
  end

  def checks_for_email
    friend_email = EmailFacade.new(current_user, params[:github_handle])
    friend_email.find_the_email
  end

  def sends_email
    InviteNotifierMailer.inform(current_user, checks_for_email).deliver_now
    flash[:notice] = "Successfully sent invite!"
    redirect_to dashboard_path
  end

  def returns_error_notice
    flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
    redirect_to dashboard_path
  end
end
