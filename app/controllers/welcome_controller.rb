class WelcomeController < ApplicationController
  def index
    @tutorials = if params[:tag]
                   Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
                 else
                   Tutorial.all.paginate(page: params[:page], per_page: 5)
                 end
  end
end
