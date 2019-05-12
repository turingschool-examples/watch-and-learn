class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @tutorials = Tutorial.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
      if current_user == nil
        @tutorials = @tutorials.where(classroom: false)
      end
    else
      @tutorials = Tutorial.all.paginate(:page => params[:page], :per_page => 5)
      if current_user == nil
        @tutorials = @tutorials.where(classroom: false)
      end
    end
  end

end
