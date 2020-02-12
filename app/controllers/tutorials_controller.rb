class TutorialsController < ApplicationController
  def index
    @tutorials = Tutorial.all
    @tutorials = Tutorial.classroom if current_user == nil
  end

  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
