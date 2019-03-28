# frozen_string_literal: true

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
    flash[:notice] = 'User must login to bookmark videos' if params[:flash]
  end
end
