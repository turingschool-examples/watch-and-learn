class TutorialsController < ApplicationController
  def index
    tutorials = Tutorial.all.to_a
    render locals: {
      facade: TutorialsFacade.new(tutorials)
    }
  end

  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
