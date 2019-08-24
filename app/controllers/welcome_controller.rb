class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @tutorials = Tutorial.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5) if current_user
      @tutorials = Tutorial.regular.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5) if current_user.nil?
    else
      @tutorials = Tutorial.all.paginate(:page => params[:page], :per_page => 5) if current_user
      @tutorials = Tutorial.regular.paginate(:page => params[:page], :per_page => 5) if current_user.nil?
    end
  end
end
