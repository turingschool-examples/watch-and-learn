class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    tutorial.update_positions
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
