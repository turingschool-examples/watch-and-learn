class TutorialsController < ApplicationController
  def index
    facade = TutorialsIndexFacade.new(current_user)
  end

  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
