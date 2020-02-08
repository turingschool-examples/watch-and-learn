class WelcomeController < ApplicationController
  def index
    if params[:tag]
      @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    elsif current_user == nil
      tutorials = Tutorial.where(classroom: false)
      @tutorials = tutorials.paginate(page: params[:page], per_page: 5)
    else
      @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
    end
  end
end
