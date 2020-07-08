class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if tutorial.classroom && !current_user
      flash[:notice] = 'You cannot access classroom content without an account.'
      redirect_to root_path
    else
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    end
  end
end
