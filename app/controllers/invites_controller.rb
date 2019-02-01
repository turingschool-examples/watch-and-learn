class InvitesController < ApplicationController
  def new
  end

  def create
    redirect_to dashboard_path
  end
end
