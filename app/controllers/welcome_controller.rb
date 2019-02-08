class WelcomeController < ApplicationController
  def index
    if current_user
      @tutorials = Tutorial.all.paginate(:page => params[:page], :per_page => 5)
    else
      @tutorials = Tutorial.no_classroom_content.paginate(:page => params[:page], :per_page => 5)
    end
  end
end
