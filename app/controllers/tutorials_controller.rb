class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if current_user && tutorial.classroom
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    elsif !tutorial.classroom
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    else
      render file: '/public/404'
    end
  end
end
