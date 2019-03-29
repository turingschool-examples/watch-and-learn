# frozen_string_literal: true

class InvitationController < ApplicationController
  def new; end

  def create
    email = service.get_user_email(params[:github_handle], current_user)
    if email
      InvitationMailer.invite(current_user.github_username, current_user.email, params[:github_handle], email).deliver_now!
      flash[:success] = 'Successfully sent invite!'
      redirect_to dashboard_path
    else
      flash[:error] = 'The Github user you selected doesn\'t have an email address associated with their account!'
      redirect_to dashboard_path
    end
  end

  def service
    GithubService.new
  end
end
