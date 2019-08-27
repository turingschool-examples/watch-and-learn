class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @tutorials = Tutorial.public(params[:tag]).paginate(:page => params[:page], :per_page => 5)
    else
      @tutorials = Tutorial.public.paginate(:page => params[:page], :per_page => 5)
    end
  end
end
