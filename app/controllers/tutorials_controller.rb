class TutorialsController < ApplicationController
  def show
    @user = current_user
    tutorial = Tutorial.find(params[:id])
    if tutorial.videos.empty?
      flash[:notice] = "The tutorial you selected has no videos."
      redirect_to root_path
    else
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    end
  end
end
