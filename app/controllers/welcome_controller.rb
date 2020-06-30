class WelcomeController < ApplicationController
  def index
    if params[:tag]
      param_prep = { page: params[:page], per_page: 5 }
      @tutorials = Tutorial.tagged_with(params[:tag]).paginate(param_prep)

    else
      @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
    end
  end
end
