# frozen_string_literal: true

class InvitesController < ApplicationController
  def new; end

  def create
    data = service.email_search(params[:invite])
    if data[:email]
      send_email(data)
    elsif data[:message]
      flash.notice = 'Not a valid Github Handle'
    else
      no_email_message
    end
    redirect_to dashboard_path
  end

  private

  def send_email(data)
    email = data[:email]
    name = data[:name]
    InviterMailer.invite(current_user, name, email).deliver_now
    flash.notice = 'Successfully sent invite!'
  end

  def no_email_message
    msg = "The Github user you selected doesn't \
      have an email address associated with their account."
    flash.notice = msg
  end

  def service
    GithubService.new(current_user)
  end
end
