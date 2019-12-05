class TutorialsController < ApplicationController

  def show
    tutorial = Tutorial.find(params[:id])
    require_user! if tutorial.classroom
    @facade = TutorialFacade.new(tutorial, params[:video_id]) 
  end

  private

  def require_user!
    if !current_user
      flash[:error] = 'You must login or register to view this page!'
      redirect_to root_path
    end
  end
end
