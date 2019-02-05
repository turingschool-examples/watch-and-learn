class WelcomeController < ApplicationController
  def index
    tutorials = if current_user
      Tutorial.all
    else
      Tutorial.without_classroom
    end

    if params[:tag]
      @tutorials = tutorials.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    else
      @tutorials = tutorials.paginate(:page => params[:page], :per_page => 5)
    end
  end
end
