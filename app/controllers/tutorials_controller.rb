class TutorialsController < ApplicationController
  def index
    render locals: {
      facade: TutorialsIndexFacade.new(current_user)
    }
  end

  def show
    render locals: {
      facade: TutorialFacade.new(Tutorial.find(params[:id]), params[:video_id])
    }
  end
end
