# frozen_string_literal: true

# invitation controller
class InvitationController < ApplicationController
  before_action :active_current_user?
  def new; end

  def create
    user = current_user
    friend = GitHubFacade.new(user).github_handle(params[:github_handle])
    if friend[:email].nil?
      flash[:notice] = "The Github user you've selected doesn't have an "\
                        'email address associated with their account.'
    else
      InvitationMailer.invite(friend, user).deliver_now
      flash[:notice] = 'Successfully sent invite!'
    end
    redirect_to dashboard_path
  end
end
