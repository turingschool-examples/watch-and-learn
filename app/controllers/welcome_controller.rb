class WelcomeController < ApplicationController
  def index
    if params[:tag]
      tagged_tutorial
    else
      tutorial
    end
  end

  private

  def tagged_tutorial
    @tutorials = if current_user
                   Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
                 else
                   Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5).where(classroom: false)
                 end
  end

  def tutorial
    @tutorials = if current_user
                   Tutorial.all.paginate(page: params[:page], per_page: 5)
                 else
                   Tutorial.all.paginate(page: params[:page], per_page: 5).where(classroom: false)
                 end
  end
end
