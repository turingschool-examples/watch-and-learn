class TutorialsController < ApplicationController
  def show
    unless current_user
      flash[:notice] = "User must login to bookmark videos."
    end
      tutorial = Tutorial.find(params[:id])
      @facade = TutorialFacade.new(tutorial, params[:video_id])
  end


end
