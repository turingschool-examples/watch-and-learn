class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @tutorials = all_tutorials(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    else
      @tutorials = all_tutorials.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def all_tutorials
    if current_user.nil?
      Tutorial.public
    else
      Tutorial.all
    end
  end
end
