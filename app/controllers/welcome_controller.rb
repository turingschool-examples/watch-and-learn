class WelcomeController < ApplicationController
  def index
    if params[:tag]
      tagged_tutorials = Tutorial.tagged_with(params[:tag])
      @tutorials = tagged_tutorials.paginate(page: params[:page], per_page: 5)
    else
      @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
    end
  end
end
