class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
    return unless params[:alert].present?

    flash.now[:alert] = 'User must login to bookmark videos.'
  end
end
