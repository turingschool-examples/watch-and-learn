class WelcomeController < ApplicationController
  def index
	if current_user
		user_tutorials
	else
		visitor_tutorials
	end
  end

  private

  def visitor_tutorials
      if params[:tag]
      	@tutorials = Tutorial.tagged_with(params[:tag]).where(classroom: false).paginate(:page => params[:page], :per_page => 5)
      else
      	@tutorials = Tutorial.where(classroom: false).paginate(:page => params[:page], :per_page => 5)
      end
   end

   def user_tutorials
       if params[:tag]
        @tutorials = Tutorial.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
      else
        @tutorials = Tutorial.all.paginate(:page => params[:page], :per_page => 5)
      end
   end
end
