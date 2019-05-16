class WelcomeController < ApplicationController
  def index
    if params[:tag]
      if current_user
        @tutorials = Tutorial.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
      else
        @tutorials = Tutorial.non_class_content.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
      end
    else
      if current_user
        @tutorials = Tutorial.all.paginate(:page => params[:page], :per_page => 5)
      else
        @tutorials = Tutorial.non_class_content.paginate(:page => params[:page], :per_page => 5)
      end
    end
  end
end
