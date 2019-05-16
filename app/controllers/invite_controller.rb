class InviteController < ApplicationController
  def new
  end

  def create
    binding.pry
    flash[:success] = "Successfully sent invite!"
    redirect_to dashboard_path
  end
end
