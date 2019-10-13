# frozen_string_literal: true

class TutorialsController < ApplicationController
  def show
    # binding.pry
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end
end
