# frozen_string_literal: true

class InvitationController < ApplicationController
  def new; end

  def create
    email = service.get_user_email(params[:github_handle], current_user)
    if email
      send_email(email)
    else
      # rubocop:disable Metrics/LineLength
      flash[:error] = 'The Github user you selected doesn\'t have an email address associated with their account!'
      # rubocop:enable Metrics/LineLength
    end
    redirect_to dashboard_path
  end

  private

  def send_email(email)
    username = current_user.github_username
    sender = current_user.email
    github_handle = params[:github_handle]
    InvitationMailer.invite(username, sender, github_handle, email).deliver_now!
    flash[:success] = 'Successfully sent invite!'
  end

  def service
    GithubService.new
  end
end
