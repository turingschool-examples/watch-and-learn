# frozen_string_literal: true

class InvitesController < ApplicationController
  def new; end

  def create
    invite = Invite.new(params[:invitee_github_handle], current_user)
    flash[:message] = if invite.send
                        'Successfully sent invite!'
                      else
                        "The Github user you selected doesn't have an e\
                        mail address associated with their account."
                      end
    redirect_to dashboard_path
  end
end
