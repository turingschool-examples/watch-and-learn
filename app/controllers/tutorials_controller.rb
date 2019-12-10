class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
    flash.now[:alert] = 'User must login to bookmark videos.' if params[:alert].present?
  end
end
