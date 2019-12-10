class WelcomeController < ApplicationController
  def index
    if params[:tag]
      tagged_tutorial
    else
      tutorial
    end
  end

  private

  # Put paginate in a presenter and call it in the view?
  # Pull out .tagged_with and .all?
  # Add .where to model method?
  
  def tagged_tutorial
    if current_user
      @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
    else
      @tutorials = Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5).where(classroom: false)
    end
  end

  def tutorial
    if current_user
      @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5)
    else
      @tutorials = Tutorial.all.paginate(page: params[:page], per_page: 5).where(classroom: false)
    end
  end
end
