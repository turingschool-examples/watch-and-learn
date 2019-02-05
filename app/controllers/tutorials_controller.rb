class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.classroom
      if current_user
        @facade = TutorialFacade.new(tutorial, params[:video_id])
      else
        four_oh_four
      end
    else
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    end
  end
end
