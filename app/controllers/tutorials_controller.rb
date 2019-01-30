class TutorialsController < ApplicationController
  before_action :require_user!

  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end

private

  def require_user!
    four_oh_four unless current_user || Tutorial.where('tutorials.classroom = ?', false)
  end
end
