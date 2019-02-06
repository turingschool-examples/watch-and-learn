class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    unless current_user
      four_oh_four if tutorial.classroom
    end
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
