# frozen_string_literal: true

class InviteEmailController < ApplicationController
  def new
    # empty
  end

  def create
    github = Github.new
    data = github.user_email(params[:github_handle])
    if !data[:email].nil?
      EmailNotifierMailer.inform(current_user, data).deliver_now
      flash[:notice] = 'Successfully sent invite!'
      redirect_to '/dashboard'
    else
      flash[:error] = 'Oops, something went wrong (probably due to email not being public).'
      redirect_to '/invite'
    end
  end
end
