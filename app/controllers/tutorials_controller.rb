class TutorialsController < ApplicationController

  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.classroom == false || current_user
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    else
      redirect_to root_path
    end
  end
end
