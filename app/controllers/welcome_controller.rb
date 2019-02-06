class WelcomeController < ApplicationController
  def index
    tutorials = get_tutorials
    if params[:tag]
      @tutorials = tutorials.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    else
      @tutorials = tutorials.paginate(:page => params[:page], :per_page => 5)
    end
  end
  
  private
  
  def get_tutorials
    if current_user
      Tutorial.all
    else
      Tutorial.where(classroom: false)
    end
  end
end
