class WelcomeController < ApplicationController
  def index
    if params[:tag]
      tagged_tutorials
    else
      tutorials
    end
  end
   
  private
    def tagged_tutorials
      if current_user
        @tutorials = Tutorial.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)     
      else 
        all_tutorials = Tutorial.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)     
        @tutorials = all_tutorials.where(classroom: false)
      end
    end

    def tutorials
      if current_user
        @tutorials = Tutorial.all.paginate(:page => params[:page], :per_page => 5)
      else
        all_tutorials = Tutorial.all.paginate(:page => params[:page], :per_page => 5)
        @tutorials = all_tutorials.where(classroom: false)  
      end
    end
end
