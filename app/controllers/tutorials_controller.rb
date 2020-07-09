class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end

  def index
    if session[:user_id]
      @tutorials = Tutorial.all
    else
      @tutorials = Tutorial.where("classroom = false")
    end
  end
end
